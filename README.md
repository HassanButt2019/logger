# 📱 logger

A powerful, developer-friendly, and test-focused **network logger and inspector** for Flutter apps. Featuring a draggable overlay, detailed API viewer, and modular architecture — this package is built to make debugging network requests smooth and scalable.

---

## 🚀 Features

| Feature                          | Description                                                             |
|----------------------------------|-------------------------------------------------------------------------|
| 🎯 Manual API Logging            | Log any request/response with custom metadata                          |
| 📟 Request/Response Inspector    | View all HTTP details: method, URL, headers, status, body              |
| 🤹 Draggable Logger Button       | Overlay button stays above all screens                                 |
| 📂 Global Log Viewer             | Access and tap through historical logs                                 |
| 🤠 Timestamped Logging           | Built-in timestamps per request                                        |
| 🥪 Test Utilities                | Mock log manager, inspect logs programmatically                        |
| 🔗 Works with any HTTP client    | Compatible with `http`, `dio`, `graphql`, etc.                         |
| ♻️ Stream API Support            | Live updates with `LoggerController.stream`                            |
| 🔐 Headless CI Mode              | Disable UI overlay during integration tests                            |
| ✅ Clean, Modular Architecture   | Core, UI, services, and models are cleanly separated                   |

---

## 📦 Installation

In your `pubspec.yaml`:

```yaml
dependencies:
  logger:
    git:
      url: https://github.com/HassanButt2019/logger.git
      ref: main
```

Then:

```bash
flutter pub get
```

---

## 🧑‍💻 Getting Started

### 1️⃣ Log API Calls

```dart
import 'package:logger/logger.dart';

NetworkLogManager().log(ApiTestData(
  method: 'GET',
  url: 'https://example.com/data',
  statusCode: 200,
  requestBody: null,
  responseBody: '{"message": "success"}',
));
```

---

### 2️⃣ Show the Logger UI

#### 🟩 Recommended (Global Injection via builder):

```dart
MaterialApp(
  builder: (context, child) {
    return Stack(
      children: [
        child ?? const SizedBox(),
        const NetwordLoggerHost(),
      ],
    );
  },
);
```

---

## 🥪 Testing Utilities

Use `LoggerController` and `NetworkLogManager()` in your test setup:

```dart
setUp(() {
  NetworkLogManager().clear();
});

test('Logs can be inspected by status', () {
  final logs = NetworkLogManager().logs;
  expect(logs.any((e) => e.statusCode == 500), true);
});
```

---

## 📁 Folder Structure

```
lib/
├—— network_logger.dart        # Public API
└—— src/
    ├—— core/                  # Log manager, controller
    ├—— models/                # ApiTestData model
    ├—— ui/                    # Overlay, log viewer, detail screens
    └—— services/              # Optional persistence/adapters
```

---

## 🔧 Planned Features

- [ ] Search & filter logs
- [ ] Log replay
- [ ] Request duration chart (profiler)
- [ ] Log export (JSON / HAR)
- [ ] Offline mock injection
- [ ] SQLite/shared_preferences persistence
- [ ] Response size and performance summary

---

## 🧑‍🔬 Why Use This Logger?

This package is built with testers and devs in mind:

- ✅ Shows logs in real-time
- ✅ Minimal setup, globally injectable
- ✅ No hard dependency on any HTTP package
- ✅ Built for extensibility, CI readiness, and test inspection

---

## 📸 Screenshots (Optional)

| Overlay Button | Log Viewer | Response Detail |
|----------------|------------|-----------------|
| ![btn](assets/button.png) | ![list](assets/list.png) | ![res](assets/response.png) |

---

## 🤝 Contributing

We welcome contributions! Please open an issue or submit a PR if you'd like to help improve this logger or implement a new feature.

---

## 📃 License

[MIT License](LICENSE)

---

> Built with ❤️ by [@HassanButt2019](https://github.com/HassanButt2019)
