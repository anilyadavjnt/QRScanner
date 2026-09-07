# 📱 QRScanner – iOS App

A modern and user-friendly **QR Code Scanner iOS application** built using **Swift and UIKit**. The app uses Apple's **AVFoundation** framework to scan QR codes quickly and efficiently.

## 🚀 Features

* 📷 Scan QR Codes using the device camera
* ⚡ Fast and accurate QR detection
* 🔐 Camera permission handling
* 🔦 Flash/Torch support
* 🎨 Clean and responsive UIKit interface
* 📱 iPhone optimized UI
* 🔗 Detect URLs and text from QR Codes
* ⚠️ Invalid/unsupported QR Code handling
* 🔄 Start and stop scanning
* 🧩 Reusable scanner implementation

## 🛠️ Technologies Used

* **Swift**
* **UIKit**
* **AVFoundation**
* **Storyboard / XIB**
* **Auto Layout**
* **iOS SDK**
* **Xcode**

## 📸 Screenshots

Add your application screenshots here.

| QR Scanner     | Scanning       | Result         |
| -------------- | -------------- | -------------- |
| Add Screenshot | Add Screenshot | Add Screenshot |

## 📂 Project Structure

```text
QRScanner-iOS/
│
├── QRScanner/
│   ├── AppDelegate.swift
│   ├── SceneDelegate.swift
│   │
│   ├── ViewControllers/
│   │   └── QRScannerViewController.swift
│   │
│   ├── Views/
│   │   └── QRScannerView.swift
│   │
│   ├── Resources/
│   │   └── Assets.xcassets
│   │
│   └── Main.storyboard
│
├── QRScanner.xcodeproj
├── README.md
└── .gitignore
```

## ⚙️ Requirements

* macOS
* Xcode
* iOS 13.0+
* Swift 5+

## 🔐 Camera Permission

The application requires camera access to scan QR codes.

Add the following permission to `Info.plist`:

```xml
<key>NSCameraUsageDescription</key>
<string>Camera access is required to scan QR codes.</string>
```

## ▶️ Installation

### 1. Clone the repository

```bash
git clone https://github.com/anilyadavjnt/QRScanner
```

### 2. Open the project

```bash
cd QRScanner-iOS
open QRScanner.xcodeproj
```

### 3. Select an iPhone Simulator or physical device

### 4. Build and Run

Press:

```text
⌘ + R
```

> ⚠️ QR scanning requires a physical iPhone because the Simulator does not provide a real camera.

## 🔍 How It Works

The application uses Apple's **AVFoundation** framework:

```text
Camera
   ↓
AVCaptureSession
   ↓
AVCaptureMetadataOutput
   ↓
QR Code Detection
   ↓
Extract QR Data
   ↓
Display Result
```

## 💡 Use Cases

* Payment QR scanning
* Website URL scanning
* Event ticket scanning
* Product information
* Contact sharing
* Authentication
* General QR code reading

## 📚 What I Learned

While developing this project, I strengthened my understanding of:

* AVFoundation
* AVCaptureSession
* AVCaptureDevice
* AVCaptureMetadataOutput
* Camera permissions
* UIKit
* Auto Layout
* Delegate pattern
* Navigation and UI handling
* QR code metadata processing

## 🔮 Future Improvements

* 📷 Scan QR from Gallery
* 📜 Scan History
* ⭐ Favorite QR Codes
* 📤 Share scanned results
* 📋 Copy result to clipboard
* 🌙 Dark Mode
* 🔦 Improved flashlight controls
* 📱 iPad support

## 👨‍💻 Author

**Anil Kumar Yadav**

iOS Developer | Swift | UIKit

* GitHub: `https://github.com/anilyadavjnt`
* LinkedIn: `https://www.linkedin.com/in/anilyadavjnt`

## ⭐ Support

If you find this project useful, consider giving it a ⭐ on GitHub.

---

### 📄 License

This project is available for educational and portfolio purposes.
