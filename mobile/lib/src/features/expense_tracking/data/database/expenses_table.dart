import 'package:drift/drift.dart';

@TableIndex(name: 'idx_expenses_trip_id', columns: {#tripId})
@TableIndex(name: 'idx_expenses_category', columns: {#category})
@TableIndex(name: 'idx_expenses_expense_date', columns: {#expenseDate})
class Expenses extends Table {
  TextColumn get id => text()();

  TextColumn get tripId => text()();

  TextColumn get category => text()();

  TextColumn get paymentMethod => text()();

  RealColumn get amount => real()();

  TextColumn get currency => text()();

  TextColumn get note => text().nullable()();

  TextColumn get photoId => text().nullable()();

  TextColumn get location => text().nullable()();

  DateTimeColumn get expenseDate => dateTime()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();

  DateTimeColumn get deletedAt => dateTime().nullable()();

  TextColumn get syncStatus => text()();

  DateTimeColumn get lastSyncedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
