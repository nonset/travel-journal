import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_journal/src/core/database/app_database.dart';
import 'package:travel_journal/src/features/expense_tracking/data/repositories/drift_expense_repository.dart';
import 'package:travel_journal/src/features/expense_tracking/domain/models/expense.dart'
    as domain;

void main() {
  late AppDatabase database;
  late DriftExpenseRepository repository;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    repository = DriftExpenseRepository(database);
  });

  tearDown(() async {
    await database.close();
  });

  test('saves and reads active expenses for one trip from SQLite', () async {
    final expense = _buildExpense(id: 'expense-1', tripId: 'trip-1');

    await repository.saveExpense(expense);

    expect(await repository.getExpensesForTrip('trip-1'), [expense]);
    expect(await repository.getExpenseById('expense-1'), expense);
  });

  test('does not return SQLite expenses from another trip', () async {
    final tripExpense = _buildExpense(id: 'expense-1', tripId: 'trip-1');
    final otherTripExpense = _buildExpense(id: 'expense-2', tripId: 'trip-2');

    await repository.saveExpense(tripExpense);
    await repository.saveExpense(otherTripExpense);

    expect(await repository.getExpensesForTrip('trip-1'), [tripExpense]);
  });

  test('updates an existing SQLite expense with the same id', () async {
    await repository.saveExpense(_buildExpense(id: 'expense-1', amount: 120));

    final updatedExpense = _buildExpense(id: 'expense-1', amount: 180);
    await repository.saveExpense(updatedExpense);

    expect(await repository.getExpensesForTrip('trip-1'), [updatedExpense]);
  });

  test('hides soft deleted SQLite expenses', () async {
    final deletedExpense = _buildExpense(
      id: 'expense-1',
    ).copyWith(deletedAt: DateTime(2026, 8, 22));

    await repository.saveExpense(deletedExpense);

    expect(await repository.getExpensesForTrip('trip-1'), isEmpty);
    expect(await repository.getExpenseById('expense-1'), isNull);
  });
}

domain.Expense _buildExpense({
  required String id,
  String tripId = 'trip-1',
  double amount = 120,
}) {
  return domain.Expense.create(
    id: id,
    tripId: tripId,
    category: domain.ExpenseCategory.food,
    paymentMethod: domain.PaymentMethod.cash,
    amount: amount,
    currency: 'THB',
    expenseDate: DateTime(2026, 10, 5),
    createdAt: DateTime(2026, 8, 21),
  );
}
