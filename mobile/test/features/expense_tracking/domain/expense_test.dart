import 'package:flutter_test/flutter_test.dart';
import 'package:travel_journal/src/features/expense_tracking/domain/models/expense.dart';
import 'package:travel_journal/src/features/trip_management/domain/models/trip.dart';

void main() {
  test('creates a local expense with trimmed and normalized values', () {
    final createdAt = DateTime(2026, 8, 21, 9, 30);

    final expense = Expense.create(
      id: 'expense-1',
      tripId: ' trip-1 ',
      category: ExpenseCategory.food,
      paymentMethod: PaymentMethod.cash,
      amount: 120.50,
      currency: ' thb ',
      expenseDate: DateTime(2026, 10, 5, 18),
      note: ' Lunch at night market ',
      location: ' Taipei ',
      createdAt: createdAt,
    );

    expect(expense.id, 'expense-1');
    expect(expense.tripId, 'trip-1');
    expect(expense.category, ExpenseCategory.food);
    expect(expense.paymentMethod, PaymentMethod.cash);
    expect(expense.amount, 120.50);
    expect(expense.currency, 'THB');
    expect(expense.expenseDate, DateTime(2026, 10, 5));
    expect(expense.note, 'Lunch at night market');
    expect(expense.location, 'Taipei');
    expect(expense.syncStatus, SyncStatus.local);
    expect(expense.createdAt, createdAt);
    expect(expense.updatedAt, createdAt);
    expect(expense.isDeleted, isFalse);
  });

  test('requires a trip id', () {
    expect(() => _buildExpense(tripId: ' '), throwsA(isA<ArgumentError>()));
  });

  test('requires a positive amount', () {
    expect(() => _buildExpense(amount: 0), throwsA(isA<ArgumentError>()));
  });

  test('requires a currency', () {
    expect(() => _buildExpense(currency: ' '), throwsA(isA<ArgumentError>()));
  });

  test('marks an expense as deleted when deletedAt exists', () {
    final deletedAt = DateTime(2026, 8, 22);
    final expense = _buildExpense().copyWith(deletedAt: deletedAt);

    expect(expense.deletedAt, deletedAt);
    expect(expense.isDeleted, isTrue);
  });
}

Expense _buildExpense({
  String tripId = 'trip-1',
  double amount = 120,
  String currency = 'THB',
}) {
  return Expense.create(
    id: 'expense-1',
    tripId: tripId,
    category: ExpenseCategory.food,
    paymentMethod: PaymentMethod.cash,
    amount: amount,
    currency: currency,
    expenseDate: DateTime(2026, 10, 5),
    createdAt: DateTime(2026, 8, 21),
  );
}
