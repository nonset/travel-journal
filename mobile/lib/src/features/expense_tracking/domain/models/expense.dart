import '../../../trip_management/domain/models/trip.dart';

enum ExpenseCategory {
  food,
  hotel,
  transport,
  shopping,
  entertainment,
  ticket,
  other,
}

enum PaymentMethod { cash, creditCard, eWallet }

class Expense {
  const Expense({
    required this.id,
    required this.tripId,
    required this.category,
    required this.paymentMethod,
    required this.amount,
    required this.currency,
    required this.expenseDate,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
    this.note,
    this.photoId,
    this.location,
    this.deletedAt,
    this.lastSyncedAt,
  });

  factory Expense.create({
    required String id,
    required String tripId,
    required ExpenseCategory category,
    required PaymentMethod paymentMethod,
    required double amount,
    required String currency,
    required DateTime expenseDate,
    required DateTime createdAt,
    String? note,
    String? photoId,
    String? location,
  }) {
    final trimmedTripId = tripId.trim();
    final normalizedCurrency = currency.trim().toUpperCase();

    if (trimmedTripId.isEmpty) {
      throw ArgumentError.value(tripId, 'tripId', 'Trip id is required.');
    }

    if (amount <= 0) {
      throw ArgumentError.value(amount, 'amount', 'Amount must be positive.');
    }

    if (normalizedCurrency.isEmpty) {
      throw ArgumentError.value(currency, 'currency', 'Currency is required.');
    }

    return Expense(
      id: id,
      tripId: trimmedTripId,
      category: category,
      paymentMethod: paymentMethod,
      amount: amount,
      currency: normalizedCurrency,
      expenseDate: DateTime(
        expenseDate.year,
        expenseDate.month,
        expenseDate.day,
      ),
      note: _trimOptional(note),
      photoId: _trimOptional(photoId),
      location: _trimOptional(location),
      createdAt: createdAt,
      updatedAt: createdAt,
      syncStatus: SyncStatus.local,
    );
  }

  final String id;
  final String tripId;
  final ExpenseCategory category;
  final PaymentMethod paymentMethod;
  final double amount;
  final String currency;
  final String? note;
  final String? photoId;
  final String? location;
  final DateTime expenseDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final SyncStatus syncStatus;
  final DateTime? lastSyncedAt;

  bool get isDeleted => deletedAt != null;

  Expense copyWith({
    String? id,
    String? tripId,
    ExpenseCategory? category,
    PaymentMethod? paymentMethod,
    double? amount,
    String? currency,
    String? note,
    String? photoId,
    String? location,
    DateTime? expenseDate,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    SyncStatus? syncStatus,
    DateTime? lastSyncedAt,
  }) {
    return Expense(
      id: id ?? this.id,
      tripId: tripId ?? this.tripId,
      category: category ?? this.category,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      note: note ?? this.note,
      photoId: photoId ?? this.photoId,
      location: location ?? this.location,
      expenseDate: expenseDate ?? this.expenseDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Expense &&
            id == other.id &&
            tripId == other.tripId &&
            category == other.category &&
            paymentMethod == other.paymentMethod &&
            amount == other.amount &&
            currency == other.currency &&
            note == other.note &&
            photoId == other.photoId &&
            location == other.location &&
            expenseDate == other.expenseDate &&
            createdAt == other.createdAt &&
            updatedAt == other.updatedAt &&
            deletedAt == other.deletedAt &&
            syncStatus == other.syncStatus &&
            lastSyncedAt == other.lastSyncedAt;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      tripId,
      category,
      paymentMethod,
      amount,
      currency,
      note,
      photoId,
      location,
      expenseDate,
      createdAt,
      updatedAt,
      deletedAt,
      syncStatus,
      lastSyncedAt,
    );
  }

  static String? _trimOptional(String? value) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return null;
    }

    return trimmed;
  }
}
