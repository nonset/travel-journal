import '../../domain/models/trip.dart';
import '../../domain/repositories/trip_repository.dart';

class InMemoryTripRepository implements TripRepository {
  InMemoryTripRepository({List<Trip>? initialTrips})
    : _trips = [...?initialTrips];

  final List<Trip> _trips;

  @override
  Future<List<Trip>> getTrips() async {
    return List.unmodifiable(_trips.where((trip) => !trip.isDeleted));
  }

  @override
  Future<Trip?> getTripById(String id) async {
    for (final trip in _trips) {
      if (trip.id == id && !trip.isDeleted) {
        return trip;
      }
    }

    return null;
  }

  @override
  Future<void> saveTrip(Trip trip) async {
    final existingIndex = _trips.indexWhere((item) => item.id == trip.id);
    if (existingIndex == -1) {
      _trips.add(trip);
      return;
    }

    _trips[existingIndex] = trip;
  }
}
