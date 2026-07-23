# 📋 Feature List

Last Updated: 2026-07-09

---

## 📦 Modules

- ✈️ Trip Management
- 💰 Expense Tracking
- 📷 Photo Memories
- 😊 Emoji Journal
- 📝 Daily Notes
- 📊 Trip Summary
- 📶 Offline Support

---

## 📊 Status Legend

...

---

## 🚀 MVP Features

This document defines every feature available in Travel Journal.

Features are grouped by module to simplify development and maintenance.

---

### 💰 Expense Tracking

### Goal

Allow travelers to record every expense in less than 5 seconds while preserving the story behind each purchase.

Travel expenses should become part of the travel experience,
not just numbers in a spreadsheet.

---

| Feature | Description | MVP | Priority | Screen | Status |
|----------|-------------|:---:|:--------:|--------|--------|
| Add Expense | Record a new expense | ✅ | 🔴 High | Add Expense | Planned |
| Edit Expense | Edit expense information | ✅ | 🟡 Medium | Expense Detail | Planned |
| Delete Expense | Delete an expense | ✅ | 🔴 High | Expense Detail | Planned |
| Expense Category | Select expense category | ✅ | 🔴 High | Add Expense | Planned |
| Payment Method | Cash / Credit Card / E-Wallet | ✅ | 🟡 Medium | Add Expense | Planned |
| Currency | Select expense currency | ✅ | 🔴 High | Add Expense | Planned |
| Expense Photos | Attach receipt or related photos | ✅ | 🟡 Medium | Expense Detail | Planned |
| Expense Location | Save where the expense occurred | ✅ | 🟢 Low | Add Expense | Planned |
| Expense Notes | Add optional notes | ✅ | 🟢 Low | Expense Detail | Planned |
| Favorite Expense | Pin important expenses | ❌ | 🔵 Future | Expense Detail | Planned |

---

#### Business Rules

- Amount must be greater than zero.
- Category is required.
- Currency is required.
- Every expense belongs to one trip.
- Expense date must be within trip dates.
- Receipt photo is optional.
- One expense can contain multiple photos.
- Location is optional.
- Notes are optional.
- Expenses cannot exist without a trip.

---

#### Future Ideas

- OCR receipt scanning
- AI category suggestion
- AI spending insights
- Budget warning
- Daily spending summary
- Expense heat map
- Monthly travel spending report
- Split bill
- Multi-currency wallet
- Smart currency conversion
- Automatic exchange rate history

---

### 💰 Expense Tracking

Record every travel expense quickly and beautifully.

Every expense should become part of the travel story,
not just numbers in a spreadsheet.

---

### 📷 Photo Memories

#### Goal

Allow travelers to preserve every memorable moment of their journey.

Photos should tell the story of the trip,
not just fill the phone gallery.


#### Description

Capture memorable travel moments through beautiful photos connected to trips, expenses, emotions, and daily notes.

Every photo becomes a meaningful part of the travel story.


#### Feature Table

| Feature | Description | MVP | Priority | Screen | Status |
|----------|-------------|:---:|:--------:|--------|--------|
| Add Photo | Add travel photos | ✅ | 🔴 High | Photo Gallery | Planned |
| Delete Photo | Remove unwanted photos | ✅ | 🔴 High | Photo Detail | Planned |
| Photo Caption | Add a caption | ✅ | 🟡 Medium | Photo Detail | Planned |
| Photo Location | Save where the photo was taken | ✅ | 🟡 Medium | Photo Detail | Planned |
| Link to Expense | Connect photo with an expense | ✅ | 🔴 High | Expense Detail | Planned |
| Link to Daily Note | Connect photo with travel notes | ✅ | 🟡 Medium | Daily Notes | Planned |
| Trip Cover | Select trip cover photo | ✅ | 🔴 High | Trip Settings | Planned |
| Favorite Photo | Mark favorite memories | ❌ | 🟢 Low | Photo Detail | Planned |
| Photo Timeline | Display photos in timeline | ✅ | 🔴 High | Timeline | Planned |
| Full Screen Viewer | View photos in full screen | ✅ | 🟡 Medium | Photo Detail | Planned |

#### Business Rules

- Every photo belongs to one trip.
- One photo may be linked to one expense.
- One photo may be linked to one daily note.
- Caption is optional.
- Location is optional.
- One trip has only one cover photo.
- Photos are deleted when the trip is deleted.
- Supported formats: JPG, PNG, HEIC.
- Photos are ordered by capture date by default.

#### Future Ideas

- AI photo caption
- AI landmark recognition
- AI best moment selection
- Memory slideshow
- Photo map
- Face grouping
- Photo filters
- Before / After comparison
- Auto memory video
- Share memory card

---

### 😊 Emoji Journal

#### Goal

Help travelers capture how they felt during every moment of the trip.

Emotions are often remembered longer than facts.

#### Description

Record emotions throughout the journey using simple emojis connected to photos, expenses, and daily notes.

Every emotion adds another layer to the travel story.

#### Feature Table

| Feature | Description | MVP | Priority | Screen | Status |
|----------|-------------|:---:|:--------:|--------|--------|
| Select Emoji | Choose an emotion | ✅ | 🔴 High | Emotion Picker | Planned |
| Emotion Note | Add a short description | ✅ | 🟡 Medium | Emotion Picker | Planned |
| Link to Photo | Connect emotion with a photo | ✅ | 🔴 High | Photo Detail | Planned |
| Link to Expense | Connect emotion with an expense | ✅ | 🟡 Medium | Expense Detail | Planned |
| Link to Daily Note | Connect emotion with daily notes | ✅ | 🟡 Medium | Daily Notes | Planned |
| Emotion Timeline | Display emotions in timeline | ✅ | 🔴 High | Timeline | Planned |
| Favorite Emotion | Pin memorable emotions | ❌ | 🟢 Low | Emotion Detail | Planned |
| Emotion Statistics | Show emotional summary | ❌ | 🔵 Future | Trip Summary | Planned |

#### Business Rules

- Every emotion belongs to one trip.
- One emotion may be linked to one photo.
- One emotion may be linked to one expense.
- One emotion may be linked to one daily note.
- Emoji selection is required.
- Emotion note is optional.
- Emotions are ordered by date and time.

#### Future Ideas

- AI emotion detection from photos
- AI emotion timeline
- Mood calendar
- Mood heat map
- Emotional journey summary
- Emotion comparison between trips
- Monthly mood report
- AI travel personality

---

### 📝 Daily Notes

#### Goal

Help travelers remember every day of their journey.

A trip is made of moments,
and every day deserves its own story.



#### Description

Capture daily experiences through travel notes connected to expenses, photos, and emotions.

Every day becomes a chapter of the travel story.


#### Feature Table

| Feature | Description | MVP | Priority | Screen | Status |
|----------|-------------|:---:|:--------:|--------|--------|
| Daily Note | Write daily journal | ✅ | 🔴 High | Daily Note | Planned |
| Edit Note | Edit daily note | ✅ | 🟡 Medium | Daily Note | Planned |
| Delete Note | Delete note | ✅ | 🔴 High | Daily Note | Planned |
| Link to Photos | Connect note with photos | ✅ | 🔴 High | Photo Detail | Planned |
| Link to Expenses | Connect note with expenses | ✅ | 🟡 Medium | Expense Detail | Planned |
| Link to Emotion | Connect note with emotion | ✅ | 🟡 Medium | Emotion Detail | Planned |
| Daily Timeline | Display notes in timeline | ✅ | 🔴 High | Timeline | Planned |
| Favorite Note | Pin favorite notes | ❌ | 🟢 Low | Daily Note | Planned |



#### Business Rules
- Every note belongs to one trip.
- One note represents one day.
- Note title is optional.
- Note content is optional.
- A note may contain photos.
- A note may link to expenses.
- A note may link to emotions.
- Notes are ordered by date.


#### Future Ideas

- AI-generated memory quote
- AI writing assistant
- AI travel diary rewrite
- Mood-based writing suggestion
- Voice-to-diary
- Travel highlights
- Daily recap card
- AI travel storytelling

--- 

### 📊 Trip Summary

#### Goal

Help travelers relive every journey after it ends.

A trip may end,
but the memories should last forever.


#### Description

Summarize the entire trip using expenses, photos, emotions, and daily notes.

Transform travel data into meaningful memories.


#### Feature Table

| Feature | Description | MVP | Priority | Screen | Status |
|----------|-------------|:---:|:--------:|--------|--------|
| Trip Overview | Show trip summary | ✅ | 🔴 High | Trip Summary | Planned |
| Expense Summary | Display total expenses | ✅ | 🔴 High | Trip Summary | Planned |
| Photo Highlights | Show memorable photos | ✅ | 🔴 High | Trip Summary | Planned |
| Emotion Summary | Show emotional overview | ✅ | 🟡 Medium | Trip Summary | Planned |
| Daily Timeline | Review trip day by day | ✅ | 🔴 High | Timeline | Planned |
| Trip Statistics | Display trip statistics | ❌ | 🟢 Low | Trip Summary | Planned |
| Favorite Moments | Highlight memorable moments | ❌ | 🟢 Low | Trip Summary | Planned |
| Share Summary | Export trip summary | ❌ | 🔵 Future | Share | Planned |


#### Business Rules

- Every trip has one summary.
- Summary is generated from trip data.
- Deleted trips cannot generate summaries.
- Statistics are calculated automatically.
- Empty modules are hidden from the summary.
- Users can regenerate summaries anytime.



#### Future Ideas

- AI-generated travel story
- AI travel magazine
- Memory slideshow
- Printable travel book (PDF)
- Travel video recap
- Compare multiple trips
- Anniversary trip reminder
- Year in Travel
- AI travel personality
- Shareable memory card

---

### 📶 Offline Support

#### Goal

Allow travelers to use Travel Journal anywhere,
even without an internet connection.

Travel memories should never depend on signal.

#### Description

Support offline recording for trips, expenses, photos, emotions, and daily notes.

Automatically synchronize data when the internet becomes available.

#### Feature Table

| Feature | Description | MVP | Priority | Screen | Status |
|----------|-------------|:---:|:--------:|--------|--------|
| Offline Recording | Save data without internet | ✅ | 🔴 High | All Screens | Planned |
| Auto Sync | Sync data automatically | ✅ | 🔴 High | Background | Planned |
| Sync Status | Display synchronization status | ✅ | 🟡 Medium | Settings | Planned |
| Retry Sync | Retry failed synchronization | ✅ | 🟡 Medium | Sync Center | Planned |
| Conflict Detection | Detect sync conflicts | ❌ | 🟢 Low | Sync Center | Planned |
| Manual Sync | Allow users to sync manually | ❌ | 🟢 Low | Settings | Planned |
| Offline Indicator | Show offline mode | ✅ | 🟡 Medium | Global UI | Planned |
| Sync History | Display synchronization history | ❌ | 🔵 Future | Settings | Planned |

#### Business Rules

- All travel records can be created offline.
- Photos are stored locally until synchronized.
- Synchronization starts automatically when internet is available.
- Failed synchronization can be retried.
- Local data always remains accessible offline.
- Users are informed of synchronization status.

#### Future Ideas

- Background synchronization
- Smart sync over Wi-Fi only
- Selective synchronization
- Offline map cache
- Automatic backup
- Cross-device synchronization
- Cloud restore
- Sync analytics


## 🚀 Platform Services

AI Planner

Social Sharing

Theme Store

Cloud Sync

Widgets

Smart Reminder

#### Goal

Provide supporting services that enhance the overall Travel Journal experience.

These services extend the platform beyond the core travel journal.

#### Description

Offer additional platform capabilities such as AI, cloud synchronization, customization, reminders, and social sharing.

These features improve usability without changing the core travel recording experience.

#### Feature Table

| Feature | Description | MVP | Priority | Screen | Status |
|----------|-------------|:---:|:--------:|--------|--------|
| AI Planner | Generate travel itinerary | ❌ | 🔵 Future | AI Planner | Planned |
| Social Sharing | Share memories to social media | ❌ | 🔵 Future | Share | Planned |
| Theme Store | Download UI themes | ❌ | 🟢 Low | Theme Store | Planned |
| Cloud Sync | Backup travel data | ❌ | 🔵 Future | Settings | Planned |
| Widgets | Home screen widgets | ❌ | 🔵 Future | Home Widget | Planned |
| Smart Reminder | Remind users to record memories | ❌ | 🟢 Low | Settings | Planned |

#### Future Ideas

- AI travel assistant
- Voice assistant
- Smart packing checklist
- Travel goals
- Apple Watch support
- Wear OS support
- Family account
- Public travel templates
- Community travel guides
- AI budget prediction

...



