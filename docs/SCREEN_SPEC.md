# 📱 Screen Specification

Version: 1.1.0

Status: Draft

Last Updated: YYYY-MM-DD

Owner: Product Team

---

# 📖 Purpose

เอกสารนี้ใช้กำหนดรายละเอียดของทุกหน้าจอ (Screen) ภายในแอป **Travel Journal**

โดยอธิบายรายละเอียดเชิง Functional และ UX เพื่อให้ทุกฝ่ายมีความเข้าใจตรงกันก่อนเริ่มพัฒนา

เอกสารนี้ครอบคลุม

- หน้าที่ของหน้าจอ
- เป้าหมายของผู้ใช้งาน
- UI Components
- User Interaction
- Navigation
- Data Source
- Repository
- Database
- Screen State
- Validation
- Error Handling
- Business Rules
- UI Rules
- Responsive Rules
- Future Improvements

---

# 📚 Related Documents

เอกสารนี้ใช้อ้างอิงร่วมกับ

- README.md
- PRD.md
- FEATURE_LIST.md
- USER_FLOW.md
- DATABASE.md
- UI_BIBLE.md
- WIREFRAME.md
- COMPONENT_SPEC.md
- API.md

---

# 📊 Screen Status Legend

| Status | Meaning |
|---------|---------|
| ⬜ Not Started | ยังไม่ได้เริ่มออกแบบ |
| 🟡 Draft | กำลังออกแบบ |
| 🔵 Review | อยู่ระหว่างการตรวจสอบ |
| 🟢 Approved | อนุมัติ พร้อมพัฒนา |
| 🚀 Implemented | พัฒนาเสร็จแล้ว |

---

# 📊 Screen Status

| No | Screen | ID | Priority | Status |
|----|--------|-----|----------|--------|
| 1 | Splash Screen | SCR-001 | High | ⬜ |
| 2 | Welcome Screen | SCR-002 | High | ⬜ |
| 3 | Home Screen | SCR-003 | High | ⬜ |
| 4 | Create Trip | SCR-004 | High | ⬜ |
| 5 | Trip Dashboard | SCR-005 | High | ⬜ |
| 6 | Expense Screen | SCR-006 | High | ⬜ |
| 7 | Photo Screen | SCR-007 | Medium | ⬜ |
| 8 | Emotion Screen | SCR-008 | Medium | ⬜ |
| 9 | Daily Notes | SCR-009 | Medium | ⬜ |
|10 | Timeline | SCR-010 | Medium | ⬜ |
|11 | Trip Summary | SCR-011 | High | ⬜ |
|12 | Settings | SCR-012 | Low | ⬜ |


---

# 🧩 Screen Specification Template

ใช้ Template นี้สำหรับทุกหน้าจอ

---

# Screen Name

Screen ID :

Priority :

Status :

---

## 🎯 Purpose

หน้าจอนี้มีหน้าที่อะไร

---

## 👤 User Goal

ผู้ใช้ต้องการทำอะไรในหน้าจอนี้

---

## 🧭 Entry Point

สามารถเข้าหน้านี้ได้จาก

- Home
- Splash
- Trip Dashboard

---

## 🚪 Exit Point

สามารถออกจากหน้านี้ไป

- Home
- Expense
- Photo

---

## 🧩 UI Components

| Component | Required | Description |
|-----------|----------|-------------|
| App Bar | ✅ | |
| Search Bar | ❌ | |
| FAB | ✅ | |

---

## 👆 User Actions

| Action | Result |
|---------|--------|
| Tap | |
| Long Press | |
| Swipe | |
| Pull Refresh | |

---

## 🔀 Navigation

ตัวอย่าง

Home

↓

Trip Dashboard

↓

Expense

---

## 🗂 Data Source

Entity ที่ใช้งาน

- Trip
- Expense
- Photo
- Emotion
- DailyNote

---

## 📦 Repository

Repository ที่เกี่ยวข้อง

- TripRepository
- SettingsRepository

---

## 💾 Database Tables

Tables

- Settings
- Trip

Reference

See DATABASE.md for Entity Relationship.

---

## 🔄 Screen States

- Loading
- Ready
- Error

---

## ⚠ Validation

System Checks

✓ Database Initialized

✓ Settings Loaded

✓ Local Storage Ready

✓ First Launch Checked

---

## 🚨 Error Handling

- Database Error
- Permission Denied
- Camera Error
- Unknown Error
- Log Error
- Retry
- Fallback

---

## 📋 Business Rules

- Splash ไม่ควรเป็นหน้าจอที่ผู้ใช้หยุดใช้งาน
- ห้ามมี User Interaction
- ห้ามแสดง Popup
- ห้ามแสดง Dialog
- ต้อง Redirect อัตโนมัติ

---

## 🎨 UI Rules

อ้างอิงจาก UI_BIBLE.md

- Spacing
- Padding
- Margin
- Corner Radius
- Elevation
- Animation
- Responsive

---

## 📱 Responsive Rules

Mobile Portrait

Mobile Landscape

Tablet

---

## 🚀 Future Improvements

ฟีเจอร์ที่จะเพิ่มในอนาคต

---

---

# 1️⃣ Splash Screen

Screen ID : SCR-001

Priority : High

Status : 🟡 Draft

---

## 🎯 Purpose

แสดงหน้าจอเริ่มต้นของแอป พร้อมเตรียมระบบที่จำเป็นก่อนเข้าสู่หน้าหลักของแอป

Splash Screen ทำหน้าที่เป็น Initialization Screen ไม่ใช่เพียงแค่แสดงโลโก้

---

## 👤 User Goal

ผู้ใช้ต้องการเปิดแอปและเข้าสู่การใช้งานได้อย่างรวดเร็ว โดยไม่ต้องรอหรือดำเนินการใด ๆ

---

## 🧭 Entry Point

- Application Launch
- Cold Start
- Warm Start
- Resume From Background

---

## 🚪 Exit Point

```text
Splash
    │
    ▼
Welcome Screen
```

---

## 🧩 UI Components

| Component | Required | Description |
|-----------|----------|-------------|
| App Logo | ✅ | โลโก้แอป |
| App Name | ✅ | ชื่อ Travel Journal |
| Loading Indicator | ✅ | แสดงสถานะกำลังโหลด |
| Background | ✅ | พื้นหลังตาม Theme |

---

## 👆 User Actions

- Tap : Disabled
- Swipe : Disabled
- Back Button : Disabled
---

## 🔀 Navigation

```text
App Launch
      │
      ▼
Splash Screen
      │
      ├── First Launch
      │      │
      │      ▼
      │  Welcome Screen
      │
      ├── Existing User
      │      │
      │      ▼
      │  Home Screen
      │
      └── Error
             │
             ▼
        Error Dialog
...
---

# 2️⃣ Welcome Screen

Screen ID : SCR-002

Priority : High

Status : ⬜ Not Started

> (รายละเอียด)

---

# 3️⃣ Home Screen

Screen ID : SCR-003

Priority : High

Status : ⬜ Not Started

> (รายละเอียด)

---

# 4️⃣ Create Trip

Screen ID : SCR-004

Priority : High

Status : ⬜ Not Started

> (รายละเอียด)

---

# 5️⃣ Trip Dashboard

Screen ID : SCR-005

Priority : High

Status : ⬜ Not Started

> (รายละเอียด)

---

# 6️⃣ Expense Screen

Screen ID : SCR-006

Priority : High

Status : ⬜ Not Started

> (รายละเอียด)

---

# 7️⃣ Photo Screen

Screen ID : SCR-007

Priority : Medium

Status : ⬜ Not Started

> (รายละเอียด)

---

# 8️⃣ Emotion Screen

Screen ID : SCR-008

Priority : Medium

Status : ⬜ Not Started

> (รายละเอียด)

---

# 9️⃣ Daily Notes

Screen ID : SCR-009

Priority : Medium

Status : ⬜ Not Started

> (รายละเอียด)

---

# 🔟 Timeline

Screen ID : SCR-010

Priority : Medium

Status : ⬜ Not Started

> (รายละเอียด)

---

# 1️⃣1️⃣ Trip Summary

Screen ID : SCR-011

Priority : High

Status : ⬜ Not Started

> (รายละเอียด)

---

# 1️⃣2️⃣ Settings

Screen ID : SCR-012

Priority : Low

Status : ⬜ Not Started

> (รายละเอียด)