# Flutter App Template

A scalable, production-ready Flutter application template built with **Feature-First Clean Architecture**. This template is designed to provide a robust starting point for medium to large-scale Flutter projects, ensuring code is maintainable, testable, and well-organized.

## 🚀 Technologies & Packages

This template is pre-configured with industry-standard packages:

*   **Routing**: [go_router](https://pub.dev/packages/go_router) for declarative routing and deep linking.
*   **State Management**: [flutter_bloc](https://pub.dev/packages/flutter_bloc) for predictable state management.
*   **Dependency Injection**: [get_it](https://pub.dev/packages/get_it) as a service locator.
*   **Networking**: [dio](https://pub.dev/packages/dio) for robust HTTP requests.

## 🏗️ Architecture

This project follows **Feature-First Clean Architecture**. The codebase is structured by feature rather than by technical layer, and each feature implements Clean Architecture principles (Domain, Data, Presentation).

For a detailed breakdown of the architecture, layers, and directory structure, please read the [PROJECT_ARCHITECTURE.md](./PROJECT_ARCHITECTURE.md).

## 📂 Project Structure Overview

```text
lib/
├── app/                  # App-wide configs, theming, and routing (GoRouter)
├── core/                 # Shared resources, utilities, network config, and DI
└── features/             # Feature modules (e.g., auth, home)
    └── [feature_name]/
        ├── data/         # Data sources, models, and repository implementations
        ├── domain/       # Entities, use cases, and repository interfaces
        └── presentation/ # UI pages, widgets, and state management (BLoC)
```

## 🛠️ Getting Started

### Prerequisites

*   Flutter SDK (v3.13.0 or higher)
*   Dart SDK

### Installation

1.  Clone the repository:
    ```bash
    git clone https://github.com/Roman-Dewan/flutter-app-template.git
    cd flutter-app-template
    ```

2.  Install dependencies:
    ```bash
    flutter pub get
    ```

3.  Run the app:
    ```bash
    flutter run
    ```

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

## 📝 License

This project is licensed under the MIT License.
