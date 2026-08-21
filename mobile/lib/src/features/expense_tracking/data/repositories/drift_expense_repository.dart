import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../trip_management/domain/models/trip.dart' as trip_domain;
import '../../domain/models/expense.dart' as domain;
import '../../domain/repositories/expense_repository.dart';

class DriftExpenseRepository implements ExpenseRepository {
  const DriftExpenseRepository(this._database);

  final AppDatabase _database;

  @override
  Future<List<domain.Expense>> getExpensesForTrip(String tripId) async {
    final rows =
        await (_database.select(_database.expenses)
              ..where(
                (expense) =>
                    expense.tripId.equals(tripId) & expense.deletedAt.isNull(),
              )
              ..orderBy([
                (expense) => OrderingTerm.desc(expense.expenseDate),
                (expense) => OrderingTerm.desc(expense.createdAt),
              ]))
            .get();

    return rows.map(_toDomain).toList(growable: false);
  }

  @override
  Future<domain.Expense?> getExpenseById(String id) async {
    final row =
        await (_database.select(_database.expenses)..where(
              (expense) => expense.id.equals(id) & expense.deletedAt.isNull(),
            ))
            .getSingleOrNull();

    if (row == null) {
      return null;
    }

    return _toDomain(row);
  }

  @override
  Future<void> saveExpense(domain.Expense expense) async {
    await _database
        .into(_database.expenses)
        .insertOnConflictUpdate(
          ExpensesCompanion(
            id: Value(expense.id),
            tripId: Value(expense.tripId),
            category: Value(expense.category.name),
            paymentMethod: Value(expense.paymentMethod.name),
            amount: Value(expense.amount),
            currency: Value(expense.currency),
            note: Value(expense.note),
            photoId: Value(expense.photoId),
            location: Value(expense.location),
            expenseDate: Value(expense.expenseDate),
            createdAt: Value(expense.createdAt),
            updatedAt: Value(expense.updatedAt),
            deletedAt: Value(expense.deletedAt),
            syncStatus: Value(expense.syncStatus.name),
            lastSyncedAt: Value(expense.lastSyncedAt),
          ),
        );
  }

  domain.Expense _toDomain(Expense row) {
    return domain.Expense(
      id: row.id,
      tripId: row.tripId,
      category: _expenseCategoryFromName(row.category),
      paymentMethod: _paymentMethodFromName(row.paymentMethod),
      amount: row.amount,
      currency: row.currency,
      note: row.note,
      photoId: row.photoId,
      location: row.location,
      expenseDate: row.expenseDate,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      deletedAt: row.deletedAt,
      syncStatus: _syncStatusFromName(row.syncStatus),
      lastSyncedAt: row.lastSyncedAt,
    );
  }

  domain.ExpenseCategory _expenseCategoryFromName(String value) {
    return domain.ExpenseCategory.values.byName(value);
  }

  domain.PaymentMethod _paymentMethodFromName(String value) {
    return domain.PaymentMethod.values.byName(value);
  }

  trip_domain.SyncStatus _syncStatusFromName(String value) {
    return trip_domain.SyncStatus.values.byName(value);
  }
}
