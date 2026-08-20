# SCR-001 : Splash Screen

---

## Purpose

Application Initialization Screen

---

## Wireframe

```text
┌──────────────────────────────────┐
│                                  │
│                                  │
│          App Logo                │
│                                  │
│       Travel Journal             │
│                                  │
│                                  │
│       Loading...                 │
│        ● ● ●                     │
│                                  │
└──────────────────────────────────┘
```

---

## Layout

| Section | Description |
|----------|-------------|
| Header | ไม่มี |
| Content | Logo + App Name |
| Footer | Loading Indicator |

---

## Navigation

```text
App Launch
      │
      ▼
Splash
      │
      ├── Welcome
      └── Home
```

---

## Components Used

- Logo
- Text
- Circular Progress Indicator

---

## Notes

- ไม่มี Interaction
- ไม่มี AppBar
- ไม่มี Bottom Navigation
- Background ใช้ Primary Background Color
- Logo อยู่กึ่งกลางหน้าจอ
- Loading Indicator อยู่ด้านล่าง Logo
- Respect Safe Area
- Theme อ้างอิงจาก UI_BIBLE.md

## Screen States

Loading

- แสดง Logo
- แสดง Loading Indicator

Error

- แสดง Error Dialog

Ready

- Navigate ไป Welcome หรือ Home

## Animation

- Logo Fade In
- Loading Indicator Fade
- Screen Fade Out ก่อน Navigate

## References

- SCREEN_SPEC.md (SCR-001)
- UI_BIBLE.md
- COMPONENT_SPEC.md
