# Service Specification

Status: Draft

This document defines application service boundaries for Travel Journal.

Travel Journal is an offline-first mobile app. Local data must remain usable even when no network is available.

---

## Service Areas

- Local storage
- Trip management
- Expense recording
- Photo handling
- Sync readiness

---

## Trip Management Persistence Plan

Status: In Progress

### Goal

Persist trip records locally so users can create and reopen travel journals without relying on network access.

### Current Code Foundation

| Layer | File | Status |
|------|------|--------|
| Domain model | `mobile/lib/src/features/trip_management/domain/models/trip.dart` | Implemented |
| Repository contract | `mobile/lib/src/features/trip_management/domain/repositories/trip_repository.dart` | Implemented |
| Temporary repository | `mobile/lib/src/features/trip_management/data/repositories/in_memory_trip_repository.dart` | Implemented |
| Drift database | `mobile/lib/src/core/database/app_database.dart` | Implemented |
| Trips table | `mobile/lib/src/features/trip_management/data/database/trips_table.dart` | Implemented |
| Drift repository | `mobile/lib/src/features/trip_management/data/repositories/drift_trip_repository.dart` | Implemented |
| Create Trip save flow | `mobile/lib/src/features/trip_management/presentation/screens/create_trip_screen.dart` | Implemented |
| Home saved trips read flow | `mobile/lib/src/features/app_entry/presentation/screens/home_screen.dart` | Implemented |

### Trip Repository Contract

The Trip repository is responsible for:

- Listing active trips
- Reading one trip by id
- Saving a new or updated trip
- Hiding soft-deleted trips from normal reads

### Local Storage Flow

```text
Create Trip Screen
      │
      ▼
Validate required fields
      │
      ▼
Create Trip domain model
      │
      ▼
TripRepository.saveTrip()
      │
      ▼
Local storage adapter
      │
      ▼
Trip Dashboard
```

### Storage Engine Decision

Decision: Use Drift on top of SQLite for the permanent local storage adapter.

Decision date: 2026-08-20

Reason:

- Travel Journal is offline-first.
- The data model has clear relationships from Trip to Expense, Photo, Emotion, Daily Note, and Trip Summary.
- The database design already defines indexes by trip, country, date, status, category, and memory type.
- Drift provides typed database access while keeping SQLite's reliable local persistence.
- SQLite is a better fit than key-value storage for queryable travel records and future summaries.

Options considered:

| Option | Best For | Notes |
|--------|----------|-------|
| Drift / SQLite | Structured offline data with relationships | Selected for MVP |
| Isar | Fast local object storage | Deferred because the product data is relational and index-heavy |
| SharedPreferences | Small settings only | Rejected for core travel data |

MVP storage direction:

Use Drift for typed data access, SQLite persistence, migrations, and local-first repository adapters.

### Persistence Rules

- Trip title is required.
- Country is required.
- Start date is required.
- End date is required.
- End date must not be before start date.
- New trips start with `TripStatus.active`.
- New local records start with `SyncStatus.local`.
- Deleted trips should be soft-deleted with `deletedAt`, not removed permanently.

### Next Implementation Step

Plan SCR-006 Expense foundation.

### Initial Drift Scope

The first storage implementation should cover only Trip records.

| Table | Purpose | Status |
|------|---------|--------|
| `trips` | Store Trip records | Implemented |

Initial `trips` columns:

- `id`
- `title`
- `country`
- `start_date`
- `end_date`
- `cover_photo_id`
- `status`
- `created_at`
- `updated_at`
- `deleted_at`
- `sync_status`
- `last_synced_at`

Initial indexes:

- `country`
- `start_date`
- `status`

Do not implement Expense, Photo, Emotion, Daily Note, or Trip Summary tables until their feature screens are ready.

### Drift Dependencies

Implemented packages:

- `drift`
- `sqlite3_flutter_libs`
- `path_provider`
- `path`
- `drift_dev`
- `build_runner`
