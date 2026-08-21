import 'package:flutter_test/flutter_test.dart';
import 'package:travel_journal/src/features/expense_tracking/data/repositories/in_memory_expense_repository.dart';
import 'package:travel_journal/src/features/expense_tracking/domain/models/expense.dart';

void main() {
  test('saves and reads active expenses for one trip', () async {
    final repository = InMemoryExpenseRepository();
    final expense = _buildExpense(id: 'expense-1', tripId: 'trip-1');

    await repository.saveExpense(expense);

    expect(await repository.getExpensesForTrip('trip-1'), [expense]);
    expect(await repository.getExpenseById('expense-1'), expense);
  });

  test('does not return expenses from another trip', () async {
    final repository = InMemoryExpenseRepository(
      initialExpenses: [
        _buildExpense(id: 'expense-1', tripId: 'trip-1'),
        _buildExpense(id: 'expense-2', tripId: 'trip-2'),
      ],
    );

    expect(await repository.getExpensesForTrip('trip-1'), [
      _buildExpense(id: 'expense-1', tripId: 'trip-1'),
    ]);
  });

  test('updates an existing expense with the same id', () async {
    final repository = InMemoryExpenseRepository();
    await repository.saveExpense(_buildExpense(id: 'expense-1', amount: 120));

    final updatedExpense = _buildExpense(id: 'expense-1', amount: 180);
    await repository.saveExpense(updatedExpense);

    expect(await repository.getExpensesForTrip('trip-1'), [updatedExpense]);
  });

  test('hides soft deleted expenses', () async {
    final repository = InMemoryExpenseRepository();
    final deletedExpense = _buildExpense(
      id: 'expense-1',
    ).copyWith(deletedAt: DateTime(2026, 8, 22));

    await repository.saveExpense(deletedExpense);

    expect(await repository.getExpensesForTrip('trip-1'), isEmpty);
    expect(await repository.getExpenseById('expense-1'), isNull);
  });
}

Expense _buildExpense({
  String id = 'expense-1',
  String tripId = 'trip-1',
  double amount = 120,
}) {
  return Expense.create(
    id: id,
    tripId: tripId,
    category: ExpenseCategory.food,
    paymentMethod: PaymentMethod.cash,
    amount: amount,
    currency: 'THB',
    expenseDate: DateTime(2026, 10, 5),
    createdAt: DateTime(2026, 8, 21),
  );
}
