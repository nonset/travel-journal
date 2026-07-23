# 👤 User Flow

Last Updated: 2026-07-XX

---

## 🎯 Purpose

Describe how users interact with Travel Journal
from the first launch to completing a trip.

---

## 👤 User Types

### Primary User

Travelers who want to record memories and expenses.

### Secondary User

Travelers who want to revisit past journeys.

---

# 🚀 Main User Journey

First Launch

↓

Create Trip

↓

Trip Dashboard

↓

Record Expenses

↓

Capture Photos

↓

Record Emotions

↓

Write Daily Notes

↓

View Timeline

↓

Complete Trip

↓

Trip Summary

↓

Share Memory

---

# 📱 Flow Details

### 🚀 Flow 1 : First Launch

#### Goal

Help users start their first journey within one minute.

#### Entry

User opens Travel Journal for the first time.

#### Flow

Splash Screen

↓

Welcome Screen

↓

Introduction (3 slides)

↓

Permission Request

↓

Home

↓

Create First Trip

#### Exit

User successfully creates the first trip.

#### Notes

- Users may skip the introduction.
- Permission requests should appear only when necessary.
- The first experience should be simple and welcoming.

#### UX Goal

Users should feel excited to begin
their journey.



### ✈️ Flow 2 : Create Trip

#### Goal

Help users create a new travel journal in less than one minute.

Creating a trip should feel exciting,
not like filling out a form.

#### Entry

User taps "Create Trip" from the Home screen.

#### Flow

Home

↓

Tap "Create Trip"

↓

Enter Trip Name

↓

Select Country

↓

Select Travel Dates

↓

Choose Cover Image (Optional)

↓

Save Trip

↓

Trip Dashboard

#### Exit

The new trip is successfully created,
and the user enters the Trip Dashboard.

#### Notes

- Trip name is required.
- Country is required.
- Cover image is optional.
- Users can edit trip information later.
- Automatically suggest a default cover image based on the selected country.

#### UX Goal

Creating a trip should feel like opening
a brand-new travel journal.

### 🏠 Flow 3 : Trip Dashboard

#### Goal

Provide a central place for users to manage every aspect of their trip.

#### UX Goal

Users should immediately feel in control of their journey,
with everything important just one tap away.

#### Entry

User opens an existing trip.

#### Flow

Home

↓

Select Trip

↓

Trip Dashboard

↓

Choose an action

├── Add Expense

├── Add Photo

├── Add Emotion

├── Add Daily Note

├── View Timeline

├── View Trip Summary

└── Trip Settings

#### Exit

User navigates to the selected feature.

#### Notes

- Dashboard is the main hub of every trip.
- Quick actions should be clearly visible.
- Recent activity should be easy to access.
- Users can return to the dashboard from any feature.

### 💰 Flow 4 : Record Expense

#### Goal

Help users record travel expenses quickly without interrupting their journey.

#### UX Goal

Recording an expense should take only a few seconds,
so users can get back to enjoying their trip.

#### Entry

User taps "Add Expense" from the Trip Dashboard.

#### Flow

Trip Dashboard

↓

Tap "Add Expense"

↓

Enter Amount

↓

Select Category

↓

Select Currency

↓

(Optional) Add Photo

↓

(Optional) Add Emotion

↓

(Optional) Add Note

↓

Save Expense

↓

Expense Detail

#### Exit

Expense is successfully recorded
and immediately appears in the trip timeline.

#### Notes

- Amount is required.
- Category is required.
- Currency defaults to the trip currency.
- Users can skip all optional fields.
- Recently used categories should appear first.
- Expense can be edited later.
- Saving should feel instant.

### 📷 Flow 5 : Capture Photo

#### Goal

Help users preserve memorable moments with beautiful travel photos.

#### UX Goal

Taking or adding a photo should feel like saving a precious memory,
not simply uploading an image.

#### Entry

User taps "Add Photo" from the Trip Dashboard or after saving an expense.

#### Flow

Trip Dashboard

↓

Tap "Add Photo"

↓

Choose Photo Source

├── Camera

└── Photo Library

↓

Select Photo(s)

↓

(Optional) Add Caption

↓

(Optional) Add Location

↓

(Optional) Link to Expense

↓

(Optional) Add Emotion

↓

Save Photo

↓

Photo Detail

#### Exit

Photo is successfully saved
and becomes part of the trip timeline.

#### Notes

- Multiple photos can be added at once.
- Caption is optional.
- Location can be automatically detected if available.
- Photos may be linked to an expense.
- Photos may include emotions.
- Users can edit photo details later.

### 😊 Flow 6 : Record Emotion

#### Goal

Help users capture how they felt during memorable moments.

#### UX Goal

Recording an emotion should take only a second,
but preserve a feeling that lasts forever.

#### Entry

User taps "Add Emotion"
from the Trip Dashboard, Photo Detail, Expense Detail, or Daily Note.

#### Flow

Open Emotion Picker

↓

Select Emoji

↓

(Optional) Add Emotion Note

↓

(Optional) Link to Photo

↓

(Optional) Link to Expense

↓

(Optional) Link to Daily Note

↓

Save Emotion

↓

Emotion Detail

#### Exit

Emotion is successfully saved
and appears in the trip timeline.

#### Notes

- Selecting an emoji is required.
- Emotion note is optional.
- Emotion can be linked to multiple memories.
- Recently used emotions should appear first.
- Users can edit emotions later.

### 📝 Flow 7 : Daily Notes

#### Goal

Help users record meaningful moments from each day of their journey.

#### UX Goal

Writing a daily note should feel like closing the chapter of a wonderful day,
not like writing a report.

#### Entry

User taps "Add Daily Note"
from the Trip Dashboard, Timeline, or after recording a memory.

#### Flow

Trip Dashboard

↓

Tap "Add Daily Note"

↓

Enter Title (Optional)

↓

Write Note

↓

(Optional) Add Photos

↓

(Optional) Link Expenses

↓

(Optional) Link Emotions

↓

Save Note

↓

Daily Note Detail

#### Exit

The daily note is saved
and becomes part of the travel timeline.

#### Notes

- Note content is optional.
- Photos may be attached.
- Expenses may be linked.
- Emotions may be linked.
- Notes are ordered by travel date.
- Users can edit notes anytime.

### 🗺️ Flow 8 : Timeline

#### Goal

Help users relive their journey through a chronological timeline of memories.

#### UX Goal

Browsing the timeline should feel like flipping through a travel journal,
not reading a list of records.

#### Entry

User taps "Timeline" from the Trip Dashboard.

#### Flow

Trip Dashboard

↓

Open Timeline

↓

Browse Memories by Date

↓

Select Memory

↓

View Memory Detail

↓

(Optional) Edit Memory

↓

Return to Timeline

#### Exit

User finishes reviewing memories
or continues recording new ones.

#### Notes

- Timeline is ordered by travel date and time.
- Expenses, photos, emotions, and daily notes appear together.
- Users can filter by memory type.
- Users can search memories.
- Timeline updates automatically after new records are added.



---