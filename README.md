# 🚀 Savvy POS Application

A modern, high-performance Point of Sale (POS) application built with **Flutter**. Designed for speed, reliability, and visual excellence, this application streamlines the checkout and refund process for retail environments.

---

## ✨ Key Features

- **🛒 Dynamic Cart Management**: Easily add, update, and manage items in the shopping cart.
- **💳 Multi-Method Payments**: Supports integrated payment flows for:
  - **Cash** (with quick-amount entry)
  - **Telebirr** (QR and Manual entry)
  - **CBE Birr** (QR and Manual entry)
  - **Bank Card** (Swipe/Insert/Tap simulation)
- **⚡ Real-time Authorization**: Secure authorization flow with digital signature capture.
- **🔄 Dynamic Refunds**: Real-time transaction history with manager PIN authorization (`123456`).
- **📄 Professional Receipts**: Generate, print, and share digital PDF receipts for both sales and refunds.
- **💎 Premium UI/UX**: Crafted with modern design principles, featuring custom widgets and smooth animations.

---

## 🛠 Tech Stack

- **Framework**: [Flutter](https://flutter.dev/)
- **Language**: [Dart](https://dart.dev/)
- **Theming**: Custom design system using `Google Fonts` and `AppColors`.
- **State Management**: Service-based singleton architecture for localized data persistence.
- **Key Plugins**:
  - `signature`: For digital signature capture.
  - `pdf` & `printing`: For high-quality receipt generation and system printing.
  - `intl`: For date and currency formatting.

---

## 🚀 Getting Started

### Prerequisites

- **Flutter SDK**: `^3.11.4` or higher.
- **Dart SDK**: Compatible with the Flutter version.
- **Simulator/Device**: Android Emulator, iOS Simulator, or a physical device.

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/Fenet-Ab/pos-fluter-app.git
   cd pos_application
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the application**:
   ```bash
   flutter run
   ```

---

## 📂 Project Structure

```text
lib/
├── core/           # Design tokens, themes, and global utils
├── models/         # Data structures (Order, Product, CartItem)
├── services/       # Business logic (TransactionService)
├── shared/         # Reusable UI widgets
└── screens/        # Feature-specific pages (Sales, Refund, Payment)
```

---

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

### Built with ❤️ by Fenet
