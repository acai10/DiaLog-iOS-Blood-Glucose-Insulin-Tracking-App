# 🩸 DiaLog – Blood Glucose & Insulin Tracking (iOS)

DiaLog is an iOS application built in Swift that allows users to track their blood glucose levels and insulin dosages over time.  
The app focuses on simple, reliable data tracking with a clean service-based architecture and fully local data persistence — no internet connection required.

---

## ✨ Features

- 🩸 **Blood glucose tracking** – Log and review blood glucose values
- 💉 **Insulin dosage tracking** – Record insulin doses alongside glucose readings
- 💾 **Local data persistence** – All data stored on-device via Realm
- 🏗️ **Service-based architecture** – Clean separation between UI, business logic, and storage
- 🔒 **Privacy by design** – No servers, no cloud, no tracking

---

## 🛠 Tech Stack

| Component | Technology |
| :--- | :--- |
| **Language** | Swift |
| **Development** | iOS SDK (Xcode) |
| **Database** | [Realm](https://github.com/realm/realm-swift) (local storage) |
| **Dependency Management** | Swift Package Manager |
| **Architecture** | Service-based architecture |
| **Testing** | Xcode Unit & UI Tests |

---

## 🏗 Project Overview

The app follows a lightweight three-layer architecture:

```
UI Layer  →  Service Layer (Business Logic)  →  Database Layer (Realm)
```

- 👤 **User Service** – Handles user-related logic and data operations  
- 💾 **Realm Service** – Manages all database interactions and persistence  

This ensures a clear separation of concerns, making the codebase easy to extend and test.

---

## 📂 Project Structure

```
├── 📁 DiaLog
│   ├── 📁 Assets.xcassets
│   │   ├── 📁 AccentColor.colorset
│   │   │   └── ⚙️ Contents.json
│   │   ├── 📁 AppIcon.appiconset
│   │   │   ├── 🖼️ AppIcon1024x1024.png
│   │   │   └── ⚙️ Contents.json
│   │   └── ⚙️ Contents.json
│   ├── 📁 ContentView
│   │   ├── 🍎 ChangePersistenceDataView.swift
│   │   ├── 🍎 DiaLogApp.swift
│   │   ├── 🍎 LoginView.swift
│   │   ├── 🍎 MainView.swift
│   │   ├── 🍎 RootView.swift
│   │   └── 🍎 UserDataView.swift
│   ├── 📁 Model
│   │   └── 🍎 model.swift
│   ├── 📁 Service
│   │   ├── 🍎 RealmService.swift
│   │   └── 🍎 UserService.swift
│   └── 📁 structure
│       ├── 🍎 button.swift
│       ├── 🍎 constants.swift
│       ├── 🍎 details.swift
│       ├── 🍎 textField.swift
│       └── 🍎 textStyle.swift
├── 📁 DiaLog.xcodeproj
│   ├── 📁 project.xcworkspace
│   │   ├── 📁 xcshareddata
│   │   │   ├── 📁 swiftpm
│   │   │   │   └── 📄 Package.resolved
│   │   │   └── 📄 WorkspaceSettings.xcsettings
│   │   └── 📄 contents.xcworkspacedata
│   └── 📄 project.pbxproj
├── 📁 DiaLogTests
│   └── 🍎 DiaLogTests.swift
├── 📁 DiaLogUITests
│   ├── 🍎 DiaLogUITests.swift
│   └── 🍎 DiaLogUITestsLaunchTests.swift
├── ⚙️ .gitignore
└── 📝 README.md
```

---

## 🚀 Running the Project

### Requirements
- macOS & Xcode
- iOS Simulator or physical iPhone

### Steps

1. **Clone the repository:**
   ```bash
   git clone git@github.com:acai10/DiaLog---iOS-Blood-Glucose-Insulin-Tracking-App.git
   ```
2. **Open in Xcode:** Open `DiaLog.xcodeproj`
3. **Resolve dependencies:** Xcode will automatically fetch the Realm package via Swift Package Manager on first launch.  
   If not: `File → Packages → Resolve Package Versions`
4. **Build & Run:** Select a simulator or device and press `Cmd + R`

---

## 🎯 Purpose

This project explores:

- **iOS application development** with Swift and SwiftUI
- **Local database persistence** using Realm
- **Service-based architecture** for clean and testable code structure
- **Handling sensitive health-related data** locally to ensure user privacy

---

## 🔮 Future Improvements

- 📊 Charts & statistics for glucose trends
- 🍎 Apple Health integration
- ☁️ Optional cloud sync support
- 🔔 Notifications & reminders for measurements
- 👥 Multi-user support

---

## 🔒 Privacy & Data Protection

User privacy is a core principle of DiaLog. All health-related data is stored **exclusively on the user's device** and never leaves it.

| | |
| :--- | :--- |
| 🚫 External servers | None |
| 🚫 Cloud synchronization | None |
| 🚫 Third-party data sharing | None |
| 🚫 Analytics or tracking | None |

---

## ⚠️ Disclaimer

This app is a technical and educational project.  
It is **not intended to replace professional medical software or medical advice**. Always consult a healthcare professional for medical decisions.