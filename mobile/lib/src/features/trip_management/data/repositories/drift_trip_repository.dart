import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/models/trip.dart' as domain;
import '../../domain/repositories/trip_repository.dart';

class DriftTripRepository implements TripRepository {
  const DriftTripRepository(this._database);

  final AppDatabase _database;

  @override
  Future<List<domain.Trip>> getTrips() async {
    final rows = await (_database.select(
      _database.trips,
    )..where((trip) => trip.deletedAt.isNull())).get();

    return rows.map(_toDomain).toList(growable: false);
  }

  @override
  Future<domain.Trip?> getTripById(String id) async {
    final row =
        await (_database.select(_database.trips)
              ..where((trip) => trip.id.equals(id) & trip.deletedAt.isNull()))
            .getSingleOrNull();

    if (row == null) {
      return null;
    }

    return _toDomain(row);
  }

  @override
  Future<void> saveTrip(domain.Trip trip) async {
    await _database
        .into(_database.trips)
        .insertOnConflictUpdate(
          TripsCompanion(
            id: Value(trip.id),
            title: Value(trip.title),
            country: Value(trip.country),
            startDate: Value(trip.startDate),
            endDate: Value(trip.endDate),
            coverPhotoId: Value(trip.coverPhotoId),
            status: Value(trip.status.name),
            createdAt: Value(trip.createdAt),
            updatedAt: Value(trip.updatedAt),
            deletedAt: Value(trip.deletedAt),
            syncStatus: Value(trip.syncStatus.name),
            lastSyncedAt: Value(trip.lastSyncedAt),
          ),
        );
  }

  domain.Trip _toDomain(Trip row) {
    return domain.Trip(
      id: row.id,
      title: row.title,
      country: row.country,
      startDate: row.startDate,
      endDate: row.endDate,
      coverPhotoId: row.coverPhotoId,
      status: _tripStatusFromName(row.status),
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      deletedAt: row.deletedAt,
      syncStatus: _syncStatusFromName(row.syncStatus),
      lastSyncedAt: row.lastSyncedAt,
    );
  }

  domain.TripStatus _tripStatusFromName(String value) {
    return domain.TripStatus.values.byName(value);
  }

  domain.SyncStatus _syncStatusFromName(String value) {
    return domain.SyncStatus.values.byName(value);
  }
}
