#!/bin/bash



echo "📁 Setting up expert-level structure..."

# Create internal lib structure
mkdir -p lib/src/core
mkdir -p lib/src/models
mkdir -p lib/src/services
mkdir -p lib/src/ui

# Create test structure
mkdir -p test/core
mkdir -p test/models
mkdir -p test/ui
mkdir -p test/integration

# Create example structure
mkdir -p example

# Create GitHub Actions workflow folder
mkdir -p .github/workflows

# Create placeholder files
touch lib/src/core/log_manager.dart
touch lib/src/core/logger_controller.dart
touch lib/src/models/api_test_data.dart
touch lib/src/services/log_persistence_service.dart
touch lib/src/ui/draggable_logger_overlay.dart
touch lib/src/ui/api_list_screen.dart
touch lib/src/ui/api_response_screen.dart
touch lib/src/ui/draggable_logger_button.dart
touch lib/network_logger.dart

touch test/core/log_manager_test.dart
touch test/models/api_test_data_test.dart
touch test/ui/draggable_logger_button_test.dart
touch test/integration/logger_overlay_test.dart

touch example/main.dart

# Add analysis options
cat <<EOF > analysis_options.yaml
include: package:flutter_lints/flutter.yaml

linter:
  rules:
    prefer_const_constructors: true
    avoid_print: true
    unnecessary_this: true
EOF

# Add GitHub Actions workflow
cat <<EOF > .github/workflows/ci.yaml
name: CI

on:
  push:
    branches: [main, develop]
  pull_request:

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Code
        uses: actions/checkout@v3

      - name: Set up Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.22.1'

      - name: Install Dependencies
        run: flutter pub get

      - name: Analyze Code
        run: flutter analyze

      - name: Run Tests
        run: flutter test --coverage

      - name: Upload Coverage to Codecov
        uses: codecov/codecov-action@v3
        with:
          files: coverage/lcov.info
EOF

# Replace README with starter
cat <<EOF > README.md
# network_logger

A customizable Flutter network logging package with draggable UI, overlay integration, and request-response tracking. Built for scalability and extensibility.

## Features

- Log HTTP methods, URLs, headers, and responses
- Draggable logger button overlay
- View and tap into logs from anywhere in your app
- Extendable with file persistence, remote logging, and more

## File Structure

See the internal architecture in [this doc](./ARCHITECTURE.md) for professional best practices.

EOF

echo "✅ Project structure created successfully!"
