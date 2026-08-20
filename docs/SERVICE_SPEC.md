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

The project has not selected a permanent local storage package yet.

Recommended next decision:

| Option | Best For | Notes |
|--------|----------|-------|
| SQLite / Drift | Structured offline data with relationships | Strong fit for Trip, Expense, Photo, Emotion, Daily Note |
| Isar | Fast local object storage | Good developer experience, but adds a larger storage decision |
| SharedPreferences | Small settings only | Not appropriate for the main travel data model |

Recommended direction for MVP:

Use SQLite or Drift for structured offline-first records, because the database design already has relationships and indexes.

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

Choose the local storage engine, then replace the temporary in-memory repository with a persistent repository adapter.
