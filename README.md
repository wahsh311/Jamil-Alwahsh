<img width="1179" height="2556" alt="Simulator Screenshot - iPhone 15 Pro - 2026-07-27 at 20 11 37" src="https://github.com/user-attachments/assets/e5369f9a-0364-490a-ae43-4b1ef0538820" /># Memorial App

A personal iOS application dedicated to the memory of my late father. It serves as a daily companion for prayers (Duaa) and tracks the time passed since his departure. 

I built this project to implement a 100% programmatic UI (no storyboards) and handle local data persistence and scheduled notifications.

## Features

- **Days Counter:** Calculates days passed using Swift's `Calendar` and `DateComponents`.
- **Duaa Display & Customization: Cycles through a list of prayers. Users can add new prayers which are saved locally.
- **Digital Rosary (Misbaha)
- **Local Notifications: Uses UserNotificationCenter to schedule background reminders.
- **App Groups Integration: the current Duaa and days passed is shared to support a home screen widget.

## Technical Details

- **Language:** Swift
- **UI:** UIKit (Programmatic layout using Auto Layout / NSLayoutConstraint)
- **Architecture:** MVC
- **Storage:** UserDefaults (Standard & Shared Suite)

## Setup

1. Clone the repository:
   ```bash
https://github.com/wahsh311/Jamil-Alwahsh

## Screenshots 

<img width="1179" height="2556" alt="Simulator Screenshot - iPhone 15 Pro - 2026-07-27 at 20 11 56" src="https://github.com/user-attachments/assets/272dd578-8d91-4741-8453-b3cb65c30a78" />
<img width="1179" height="2556" alt="Simulator Screenshot - iPhone 15 Pro - 2026-07-27 at 20 11 48" src="https://github.com/user-attachments/assets/cd3684ba-a364-4e18-98ab-12d9d1dbeffb" />
<img width="1179" height="2556" alt="Simulator Screenshot - iPhone 15 Pro - 2026-07-27 at 20 11 37" src="https://github.com/user-attachments/assets/1e8d3af0-3ebc-415e-94f5-ce98a99b90bb" />
