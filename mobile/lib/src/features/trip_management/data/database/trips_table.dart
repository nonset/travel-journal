import 'package:drift/drift.dart';

@TableIndex(name: 'idx_trips_country', columns: {#country})
@TableIndex(name: 'idx_trips_start_date', columns: {#startDate})
@TableIndex(name: 'idx_trips_status', columns: {#status})
class Trips extends Table {
  TextColumn get id => text()();

  TextColumn get title => text()();

  TextColumn get country => text()();

  DateTimeColumn get startDate => dateTime()();

  DateTimeColumn get endDate => dateTime()();

  TextColumn get coverPhotoId => text().nullable()();

  TextColumn get status => text()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();

  DateTimeColumn get deletedAt => dateTime().nullable()();

  TextColumn get syncStatus => text()();

  DateTimeColumn get lastSyncedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
