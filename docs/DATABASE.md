# 🗄️ Database Design

Last Updated: 2026-07-XX

---

## 📖 Purpose

Define all data models used in Travel Journal.

The database is designed to support offline-first recording,
beautiful travel memories,
and future AI features.

---

## 📦 Entities

- Trip
- Expense
- Photo
- Emotion
- Daily Note
- Trip Summary

---

## 🔗 Entity Relationship

Trip
 ├── Expense
 │     └── Photo
 │
 ├── Photo
 │
 ├── Emotion
 │
 ├── Daily Note
 │
 └── Trip Summary

---

## 📄 Entity Details

### 🚗 Trip

#### Purpose

Represents one travel journal.

A Trip is the root entity of the application and contains all travel-related records such as expenses, photos, emotions, daily notes, and trip summaries.

---

#### Fields

| Field | Type | Required | Description |
|--------|------|:--------:|-------------|
| id | UUID | ✅ | Primary key |
| title | String | ✅ | Trip name |
| country | String | ✅ | Main destination country |
| startDate | Date | ✅ | Trip start date |
| endDate | Date | ✅ | Trip end date |
| coverPhotoId | UUID | ❌ | Related cover photo |
| status | TripStatus | ✅ | Current trip status |
| createdAt | DateTime | ✅ | Created timestamp |
| updatedAt | DateTime | ✅ | Last updated timestamp |
| deletedAt | DateTime | ❌ | Soft delete timestamp |
| syncStatus | SyncStatus | ✅ | Current synchronization status |
| lastSyncedAt | DateTime | ❌ | Last successful synchronization |

---

#### Relationships

Trip

├── Expenses (1:N)

├── Photos (1:N)

├── Emotions (1:N)

├── Daily Notes (1:N)

└── Trip Summary (1:1)

---

#### Notes

- Every Trip must have one primary country.
- A Trip can exist without expenses or photos.
- Only one Trip Summary exists for each Trip.
- Trips are never permanently deleted.
- Completed trips become read-only by default.

### 💰 Expense

#### Purpose

Stores every expense recorded during a trip.

Expenses contribute to statistics, summaries, budgets, and AI insights.

---

#### Fields

| Field | Type | Required | Description |
|--------|------|:--------:|-------------|
| id | UUID | ✅ | Primary key |
| tripId | UUID | ✅ | Related Trip |
| category | ExpenseCategory | ✅ | Expense category |
| amount | Double | ✅ | Expense amount |
| currency | String | ✅ | Currency code (THB, JPY, USD...) |
| note | Text | ❌ | Expense note |
| photoId | UUID | ❌ | Linked receipt photo |
| location | String | ❌ | Expense location |
| expenseDate | DateTime | ✅ | Expense date |
| createdAt | DateTime | ✅ | Created timestamp |
| updatedAt | DateTime | ✅ | Last updated timestamp |
| deletedAt | DateTime | ❌ | Soft delete timestamp |
| syncStatus | SyncStatus | ✅ | Synchronization status |
| lastSyncedAt | DateTime | ❌ | Last successful synchronization |

---

#### Relationships

Expense

├── belongs to Trip (N:1)

└── may have one Photo

---

#### Notes

- Amount must be greater than zero.
- Currency is required.
- Expense date must be within the trip period.
- Receipt photo is optional.
- Expenses participate in Timeline and Trip Summary.


### 📷 Photo

#### Purpose

Stores travel photos connected to memories.

Photos may be linked to expenses, emotions, or daily notes.

---

#### Fields

| Field | Type | Required | Description |
|--------|------|:--------:|-------------|
| id | UUID | ✅ | Primary key |
| tripId | UUID | ✅ | Related Trip |
| expenseId | UUID | ❌ | Related Expense |
| caption | Text | ❌ | Photo caption |
| location | String | ❌ | Capture location |
| imagePath | String | ✅ | Local or cloud image path |
| takenAt | DateTime | ❌ | Capture time |
| isFavorite | Boolean | ✅ | Favorite photo |
| createdAt | DateTime | ✅ | Created timestamp |
| updatedAt | DateTime | ✅ | Last updated timestamp |
| deletedAt | DateTime | ❌ | Soft delete timestamp |
| syncStatus | SyncStatus | ✅ | Synchronization status |
| lastSyncedAt | DateTime | ❌ | Last synchronization |

---

#### Relationships

Photo

├── belongs to Trip

├── may belong to Expense

├── may have Emotion

└── may appear in Daily Note

---

#### Notes

- Photos remain available offline.
- Only one photo can be selected as Trip Cover.
- Favorite photos appear in Trip Summary.

### 😊 Emotion

#### Purpose

Represents how the traveler felt during a specific moment.

---

#### Fields

| Field | Type | Required | Description |
|--------|------|:--------:|-------------|
| id | UUID | ✅ | Primary key |
| tripId | UUID | ✅ | Related Trip |
| emotionType | EmotionType | ✅ | Selected emotion |
| note | Text | ❌ | Emotion note |
| photoId | UUID | ❌ | Related Photo |
| expenseId | UUID | ❌ | Related Expense |
| dailyNoteId | UUID | ❌ | Related Daily Note |
| createdAt | DateTime | ✅ | Created timestamp |
| updatedAt | DateTime | ✅ | Last updated timestamp |
| deletedAt | DateTime | ❌ | Soft delete timestamp |
| syncStatus | SyncStatus | ✅ | Synchronization status |
| lastSyncedAt | DateTime | ❌ | Last synchronization |

---

#### Relationships

Emotion

├── belongs to Trip

├── may belong to Photo

├── may belong to Expense

└── may belong to Daily Note

---

#### Notes

- Every Emotion belongs to exactly one Trip.
- Linking to other entities is optional.




### 📝 Daily Note

#### Purpose

Stores daily journal entries during the trip.

---

#### Fields

| Field | Type | Required | Description |
|--------|------|:--------:|-------------|
| id | UUID | ✅ | Primary key |
| tripId | UUID | ✅ | Related Trip |
| title | String | ❌ | Note title |
| content | Text | ✅ | Journal content |
| noteDate | Date | ✅ | Related travel day |
| createdAt | DateTime | ✅ | Created timestamp |
| updatedAt | DateTime | ✅ | Last updated timestamp |
| deletedAt | DateTime | ❌ | Soft delete timestamp |
| syncStatus | SyncStatus | ✅ | Synchronization status |
| lastSyncedAt | DateTime | ❌ | Last synchronization |

---

#### Relationships

Daily Note

├── belongs to Trip

├── may contain Photos

├── may contain Emotions

└── may reference Expenses

---

#### Notes

- One Daily Note represents one travel day.
- Content may be empty.
- AI writing assistance is optional.
...

### 📖 Trip Summary

#### Purpose

Stores the generated summary of a completed trip.

---

#### Fields

| Field | Type | Required | Description |
|--------|------|:--------:|-------------|
| id | UUID | ✅ | Primary key |
| tripId | UUID | ✅ | Related Trip |
| story | Text | ❌ | Generated travel story |
| totalExpense | Double | ✅ | Total expenses |
| photoCount | Integer | ✅ | Number of photos |
| emotionCount | Integer | ✅ | Number of emotions |
| noteCount | Integer | ✅ | Number of notes |
| generatedAt | DateTime | ✅ | Summary generation time |
| createdAt | DateTime | ✅ | Created timestamp |
| updatedAt | DateTime | ✅ | Last updated timestamp |
| syncStatus | SyncStatus | ✅ | Synchronization status |

---

#### Relationships

Trip
├── Expenses
│     └── (may reference Photo)
│
├── Photos
│
├── Emotions
│
├── Daily Notes
│
└── Trip Summary

---

#### Notes

- One Summary per Trip.
- Can be regenerated anytime.
- AI story is optional.


---

## 📚 Common Types

| Type | Description |
|------|-------------|
| UUID | Unique identifier |
| String | Short text |
| Text | Long text |
| Integer | Whole number |
| Double | Decimal number |
| Boolean | True / False |
| Date | Date only |
| DateTime | Date and time |
| Enum | Fixed value |

---

## 📋 Enums

### TripStatus

- Active
- Completed
- Archived

### ExpenseCategory

- Food
- Hotel
- Transport
- Shopping
- Entertainment
- Ticket
- Other

### EmotionType

- Happy
- Excited
- Relaxed
- Tired
- Love
- Sad

### SyncStatus

- Local
- Pending
- Synced
- Failed


---

## 📈 Suggested Indexes
Trip

Trip
- country
- startDate
- status

Expense
- tripId
- category
- expenseDate

Photo
- tripId
- takenAt

Emotion
- tripId
- emotionType

DailyNote
- tripId
- noteDate
