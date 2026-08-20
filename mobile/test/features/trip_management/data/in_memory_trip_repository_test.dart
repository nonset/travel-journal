import 'package:flutter_test/flutter_test.dart';
import 'package:travel_journal/src/features/trip_management/data/repositories/in_memory_trip_repository.dart';
import 'package:travel_journal/src/features/trip_management/domain/models/trip.dart';

void main() {
  test('saves and reads active trips', () async {
    final repository = InMemoryTripRepository();
    final trip = _buildTrip(id: 'trip-1', title: 'Taiwan Beta Trip 2026');

    await repository.saveTrip(trip);

    expect(await repository.getTrips(), [trip]);
    expect(await repository.getTripById('trip-1'), trip);
  });

  test('updates an existing trip with the same id', () async {
    final repository = InMemoryTripRepository();
    await repository.saveTrip(_buildTrip(id: 'trip-1', title: 'Taiwan'));

    final updatedTrip = _buildTrip(id: 'trip-1', title: 'Taiwan Summer');
    await repository.saveTrip(updatedTrip);

    expect(await repository.getTrips(), [updatedTrip]);
  });

  test('hides soft deleted trips', () async {
    final repository = InMemoryTripRepository();
    final deletedTrip = _buildTrip(
      id: 'trip-1',
      title: 'Taiwan',
    ).copyWith(deletedAt: DateTime(2026, 8, 21));

    await repository.saveTrip(deletedTrip);

    expect(await repository.getTrips(), isEmpty);
    expect(await repository.getTripById('trip-1'), isNull);
  });
}

Trip _buildTrip({required String id, required String title}) {
  return Trip.create(
    id: id,
    title: title,
    country: 'Taiwan',
    startDate: DateTime(2026, 10, 5),
    endDate: DateTime(2026, 10, 8),
    createdAt: DateTime(2026, 8, 20),
  );
}
