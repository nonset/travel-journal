import 'package:flutter_test/flutter_test.dart';
import 'package:travel_journal/src/features/trip_management/domain/models/trip.dart';

void main() {
  test('creates an active local trip with trimmed values', () {
    final createdAt = DateTime(2026, 8, 20, 12, 30);

    final trip = Trip.create(
      id: 'trip-1',
      title: ' Taiwan Beta Trip 2026 ',
      country: ' Taiwan ',
      startDate: DateTime(2026, 10, 5, 18),
      endDate: DateTime(2026, 10, 8, 8),
      createdAt: createdAt,
    );

    expect(trip.id, 'trip-1');
    expect(trip.title, 'Taiwan Beta Trip 2026');
    expect(trip.country, 'Taiwan');
    expect(trip.startDate, DateTime(2026, 10, 5));
    expect(trip.endDate, DateTime(2026, 10, 8));
    expect(trip.status, TripStatus.active);
    expect(trip.syncStatus, SyncStatus.local);
    expect(trip.createdAt, createdAt);
    expect(trip.updatedAt, createdAt);
    expect(trip.isDeleted, isFalse);
  });

  test('marks a trip as deleted when deletedAt exists', () {
    final createdAt = DateTime(2026, 8, 20);
    final deletedAt = DateTime(2026, 8, 21);
    final trip = Trip.create(
      id: 'trip-1',
      title: 'Taiwan',
      country: 'Taiwan',
      startDate: createdAt,
      endDate: createdAt,
      createdAt: createdAt,
    ).copyWith(deletedAt: deletedAt);

    expect(trip.deletedAt, deletedAt);
    expect(trip.isDeleted, isTrue);
  });
}
