import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_journal/src/core/database/app_database.dart';
import 'package:travel_journal/src/features/trip_management/data/repositories/drift_trip_repository.dart';
import 'package:travel_journal/src/features/trip_management/domain/models/trip.dart'
    as domain;

void main() {
  late AppDatabase database;
  late DriftTripRepository repository;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    repository = DriftTripRepository(database);
  });

  tearDown(() async {
    await database.close();
  });

  test('saves and reads active trips from SQLite', () async {
    final trip = _buildTrip(id: 'trip-1', title: 'Taiwan Beta Trip 2026');

    await repository.saveTrip(trip);

    expect(await repository.getTrips(), [trip]);
    expect(await repository.getTripById('trip-1'), trip);
  });

  test('updates an existing SQLite trip with the same id', () async {
    await repository.saveTrip(_buildTrip(id: 'trip-1', title: 'Taiwan'));

    final updatedTrip = _buildTrip(id: 'trip-1', title: 'Taiwan Summer');
    await repository.saveTrip(updatedTrip);

    expect(await repository.getTrips(), [updatedTrip]);
  });

  test('hides soft deleted SQLite trips', () async {
    final deletedTrip = _buildTrip(
      id: 'trip-1',
      title: 'Taiwan',
    ).copyWith(deletedAt: DateTime(2026, 8, 21));

    await repository.saveTrip(deletedTrip);

    expect(await repository.getTrips(), isEmpty);
    expect(await repository.getTripById('trip-1'), isNull);
  });
}

domain.Trip _buildTrip({required String id, required String title}) {
  return domain.Trip.create(
    id: id,
    title: title,
    country: 'Taiwan',
    startDate: DateTime(2026, 10, 5),
    endDate: DateTime(2026, 10, 8),
    createdAt: DateTime(2026, 8, 20),
  );
}
