# iOS Folder Structure Example

Recommended folder structure for iOS projects using Swift/SwiftUI and Clean Architecture. Only essential, practical folders are included.

## Important

- Do not create empty folders. Only add a section if it contains content.

```text
App/                       // App entry point, configuration, orchestration
├── Configuration/         // App settings, feature flags, build configurations
├── Launch/                // App and scene launch logic, DI setup
├── MainApp.swift          // SwiftUI App entry point
├── Coordinator/
│   └── Waypoints     // Navigation and flow coordination between features
├── Services/              // Application service implementations
└── Mappers/               // Mapping between domain and application DTOs

────────────

Domain/                    // Pure business logic, no external dependencies
├── Entities/              // Core business models and value objects
├── UseCases/              // Business rules, interactors implementing application logic
├── Repositories/          // Repository interfaces (protocols)
├── Services/              // Domain service interfaces
├── Errors/                // Domain-specific errors
└── ValueObjects/          // Value objects ensuring invariants

────────────

Data/                      // Data layer implementations (repositories, data sources)
├── Repositories/          // Implementations of repository interfaces from Domain
├── DataSources/           // Network, local database, cache, keychain sources
│   ├── Local/             // Local data sources (e.g., CoreData, files)
│   └── Remote/            // Remote data sources (e.g., API clients)
├── Mappers/               // Data transformation between DTOs and domain models
├── DTOs/                  // Data Transfer Objects for network/database
└── Persistence/           // CoreData, SwiftData or other persistence logic

────────────

Presentation/              // UI layer, ViewModels, navigation, shared UI components
├── Screens/               // Features grouped by screens
│   └── FeatureName/       // Folder for a specific feature
│       ├── View/          // SwiftUI Views for the feature
│       ├── ViewModel/     // ViewModels for the feature
│       └── Navigation/    // Feature-specific navigation logic
├── Shared/                // Reusable UI components and modifiers
│   ├── Components/        // Shared UI components
│   └── Modifiers/         // Shared view modifiers
└── Navigation/            // Global navigation and routing logic

────────────

Resources/                 // Assets, localization, fonts, and config files
├── Assets.xcassets/       // Image and color assets
├── Localization/          // Localized strings and resources
├── Fonts/                 // Custom fonts
└── Info.plist             // Application configuration

────────────

Tests/                     // Automated tests
├── UnitTests/             // Unit tests for business and data logic
│   ├── DomainTests/       // Tests for business logic
│   ├── DataTests/         // Tests for data layer
│   └── ApplicationTests/  // Tests for application services and orchestration
└── UITests/               // UI tests per feature or flow
    └── Screens/           // UI tests for screens
```

---

**Key Folders:**

- `App/`: Entry point, configuration, orchestration, navigation, and application services
- `Domain/`: Pure business logic, no dependencies
- `Data/`: Data access, persistence, mapping
- `Presentation/`: UI, ViewModels, navigation
- `Tests/`: Unit and UI tests

---

## Optional Folders

The following folders are **optional** and should be used only in large projects or when the corresponding patterns are required.

```text
State/     // (Optional) Shared UI state types. Use if UI state structures are reused or complex.
Models/    // (Optional) Shared UI models (ViewData). Use if ViewData types are reused or numerous.
Commands/  // (Optional) Command handlers for state mutations (CQRS). Use only if you apply CQRS or have complex write operations.
Queries/   // (Optional) Query handlers for read operations (CQRS). Use only if you apply CQRS or have complex read operations.
```

- **State/**: Place shared or complex UI state types here if they are reused between multiple ViewModels or screens. For most projects, keep state types inside the relevant ViewModel.
- **Models/**: Place shared UI models (ViewData) here if they are reused or if the project is large. Otherwise, keep them next to the relevant View or ViewModel.
- **Commands/**: Use only if you implement CQRS or have complex business logic that requires strict separation of write operations. Not needed in most iOS projects.
- **Queries/**: Use only if you implement CQRS or have complex business logic that requires strict separation of read operations. Not needed in most iOS projects.
