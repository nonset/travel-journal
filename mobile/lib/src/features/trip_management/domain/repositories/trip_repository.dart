import '../models/trip.dart';

abstract class TripRepository {
  Future<List<Trip>> getTrips();

  Future<Trip?> getTripById(String id);

  Future<void> saveTrip(Trip trip);
}
