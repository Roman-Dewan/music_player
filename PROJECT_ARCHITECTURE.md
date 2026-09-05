# Project Architecture

This project strictly follows the **Feature-First Clean Architecture** principles. This approach ensures scalability, maintainability, and a clear separation of concerns.

## Overview

The codebase is primarily divided into three main areas inside the `lib/` directory:

1. **`app/`**: Contains app-wide configurations (Routing, Theming, App setup).
2. **`core/`**: Contains shared components and utilities that can be used across multiple features.
3. **`features/`**: Contains the actual business features of the application, each structured internally using Clean Architecture.

## Directory Structure

```text
lib/
├── app/                  # Global App Configuration
│   ├── config/           # App-wide configurations (e.g., app_config.dart)
│   ├── router/           # Navigation and routing setup (GoRouter)
│   └── theme/            # Global theme and color palettes
├── core/                 # Shared resources and logic across features
│   ├── constants/        # Global constants
│   ├── di/               # Dependency Injection setup (GetIt)
│   ├── error/            # Custom Exceptions and Failures
│   ├── network/          # Network clients (Dio) and network info
│   ├── service/          # Shared services (Background, Image, Location, etc.)
│   └── utils/            # Extension methods, validators, and helpers
└── features/             # The core functionality divided by feature
    ├── auth/             # Example Feature: Authentication
    └── home/             # Example Feature: Home Dashboard
```

## Feature Structure (Clean Architecture)

Inside each feature (e.g., `lib/features/auth/`), the code is divided into three distinct layers:

### 1. Domain Layer (`domain/`)
This is the innermost layer and the heart of the feature. It does not depend on anything outside of itself (no Flutter dependencies, no third-party libraries).
*   **Entities**: Core business objects and data structures.
*   **Use Cases**: Classes that encapsulate a specific piece of business logic or action.
*   **Repositories (Interfaces)**: Abstract definitions of how data should be accessed. The domain layer defines *what* is needed, but not *how* to get it.

### 2. Data Layer (`data/`)
This layer is responsible for fetching, storing, and manipulating data. It implements the repository interfaces defined in the Domain layer.
*   **Data Sources**: Classes responsible for fetching data directly (e.g., from a REST API via Dio, or from a local database).
*   **Models**: Data Transfer Objects (DTOs) that map external data (like JSON) into Domain Entities.
*   **Repository Implementations**: The actual implementations of the repository interfaces defined in the Domain layer.

### 3. Presentation Layer (`presentation/`)
This is the outermost layer responsible for displaying the UI and handling user interaction.
*   **BLoC/Controllers**: State management classes that communicate with Use Cases and update the UI state.
*   **Pages/Screens**: Full-screen Flutter widgets representing a distinct view.
*   **Widgets**: Reusable, smaller UI components specific to this feature.

## Benefits of this Architecture

*   **Scalable:** Adding a new feature doesn't clutter existing code; you simply create a new folder under `features/`.
*   **Testable:** The strict boundary between layers makes unit testing extremely straightforward. You can test domain logic without touching the UI or database.
*   **Maintainable:** Code is easy to locate. If there is a bug in the Auth screen, you know exactly where to look (`features/auth/presentation/pages`).
*   **Independent:** Features can be developed and updated independently by different team members.
