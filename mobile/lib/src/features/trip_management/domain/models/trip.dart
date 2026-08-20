enum TripStatus { active, completed, archived }

enum SyncStatus { local, pending, synced, failed }

class Trip {
  const Trip({
    required this.id,
    required this.title,
    required this.country,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
    this.coverPhotoId,
    this.deletedAt,
    this.lastSyncedAt,
  });

  factory Trip.create({
    required String id,
    required String title,
    required String country,
    required DateTime startDate,
    required DateTime endDate,
    required DateTime createdAt,
  }) {
    return Trip(
      id: id,
      title: title.trim(),
      country: country.trim(),
      startDate: DateTime(startDate.year, startDate.month, startDate.day),
      endDate: DateTime(endDate.year, endDate.month, endDate.day),
      status: TripStatus.active,
      createdAt: createdAt,
      updatedAt: createdAt,
      syncStatus: SyncStatus.local,
    );
  }

  final String id;
  final String title;
  final String country;
  final DateTime startDate;
  final DateTime endDate;
  final String? coverPhotoId;
  final TripStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final SyncStatus syncStatus;
  final DateTime? lastSyncedAt;

  bool get isDeleted => deletedAt != null;

  Trip copyWith({
    String? id,
    String? title,
    String? country,
    DateTime? startDate,
    DateTime? endDate,
    String? coverPhotoId,
    TripStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    SyncStatus? syncStatus,
    DateTime? lastSyncedAt,
  }) {
    return Trip(
      id: id ?? this.id,
      title: title ?? this.title,
      country: country ?? this.country,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      coverPhotoId: coverPhotoId ?? this.coverPhotoId,
      status: status ?? this.status,
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
        other is Trip &&
            id == other.id &&
            title == other.title &&
            country == other.country &&
            startDate == other.startDate &&
            endDate == other.endDate &&
            coverPhotoId == other.coverPhotoId &&
            status == other.status &&
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
      title,
      country,
      startDate,
      endDate,
      coverPhotoId,
      status,
      createdAt,
      updatedAt,
      deletedAt,
      syncStatus,
      lastSyncedAt,
    );
  }
}
