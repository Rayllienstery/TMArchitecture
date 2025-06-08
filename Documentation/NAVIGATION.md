# Navigation Architecture

## Overview

This document describes a scalable, modular navigation architecture for SwiftUI projects, based on the use of feature-specific waypoints, a centralized Coordinator, and feature routers. The approach is suitable for medium and large projects, and can be easily adapted for any team or product.

```swift
[ ViewModel ] ───▶ [ FeatureRouter ] ───▶ [ Coordinator ] ───▶ [ NavigationPath ]
                                         ▲              │
                                 [ Waypoint enum ] ◀────┘
```

## Key Concepts

### 1. Coordinator

- **Role:** Centralizes navigation logic and manages the navigation stack (e.g., using `NavigationPath`).
- **Responsibilities:**
  - Receives navigation requests from routers or view models.
  - Appends navigation destinations (waypoints) to the stack.
  - Decouples navigation logic from UI and business logic.
- **Best Practice:** Should be a singleton or injected via environment for global access.

### 2. Waypoint (Feature Waypoints)

- **Role:** Encapsulates all possible navigation destinations for a specific feature or module.
- **Pattern:**
  - Each feature (e.g., Home, Shopping, Settings, Premium, Guides, etc.) defines its own enum (e.g., `HomeWaypoint`, `ShoppingWaypoint`).
  - The root `Waypoint` enum contains only cases for each feature, e.g.:

    ```swift
    enum Waypoint {
      case home(HomeWaypoint)
      case shopping(ShoppingWaypoint)
      case settings(SettingsWaypoint)
      case premium(PremiumWaypoint)
      case guides(GuidesWaypoint)
      // ...
    }
    ```

  - Each feature waypoint enum implements a method to return the corresponding SwiftUI view.
- **Benefits:**
  - Separation of concerns: each feature manages its own navigation.
  - Easy to scale: add new features without touching unrelated code.
  - Improves code readability and maintainability.

### 3. Router (Feature Router)

- **Role:** Provides a simple API for navigation within a feature.
- **Pattern:**
  - Each feature has its own router protocol and implementation.
  - Routers translate high-level navigation intents into concrete waypoints and pass them to the Coordinator.
- **Example:**

    ```swift
    protocol FeatureRouter {
      func routeToSomeScreen()
      func routeToAnotherScreen()
    }
    ```

### 4. ViewModel

- **Role:** Calls router methods to trigger navigation in response to user actions or business logic.
- **Best Practice:** ViewModels should not know about the Coordinator or navigation stack directly.

## Example Structure

```text
Navigation/
  Waypoints/
    HomeWaypoint.swift
    ShoppingWaypoint.swift
    SettingsWaypoint.swift
    PremiumWaypoint.swift
    GuidesWaypoint.swift
    DailyPlannerWaypoint.swift
    Waypoint.swift
  Coordinator.swift

Views/Feature/
  FeatureView.swift
  FeatureViewModel.swift
  FeatureRouter.swift
```

## Example: Adding a New Feature Waypoint

1. **Create a new enum for the feature:**

    ```swift
    enum FeatureWaypoint {
      case main
      case details(id: UUID)
      // ...
      @MainActor
      func view(_ coordinator: Coordinator) -> AnyView { ... }
    }
    ```

2. **Add a case to the root Waypoint:**

    ```swift
    case feature(FeatureWaypoint)
    ```

3. **Delegate in the root Waypoint's view method:**

    ```swift
    case .feature(let featureWaypoint):
      return featureWaypoint.view(coordinator)
    ```

4. **Update the feature router to use the new waypoint.**

## Best Practices

- **Single Responsibility:** Each waypoint enum and router should only handle its own feature.
- **Type Safety:** Use enums and associated values for navigation to avoid stringly-typed routes.
- **Scalability:** Add new features by creating new waypoint enums and router protocols, not by expanding a monolithic navigation enum.
- **Testability:** Routers and ViewModels can be easily tested and mocked.
- **Readability:** Navigation logic is explicit and easy to follow.
- **Extensibility:** Easy to add deep linking, analytics, or custom transitions by extending Coordinator or routers.

## FAQ

**Q: How do I add a new screen to a feature?**  
A: Add a new case to the feature's waypoint enum and update its `view(_:)` method.

**Q: How do I navigate from one feature to another?**  
A: Use the root Waypoint enum and pass the appropriate feature waypoint as an associated value.

**Q: Can I use this with UIKit or other navigation stacks?**  
A: The pattern is adaptable, but this documentation is focused on SwiftUI and NavigationStack.

## Summary

This navigation architecture provides a clean, modular, and scalable way to manage navigation in SwiftUI projects. By using feature-specific waypoints, a centralized coordinator, and routers, you ensure your codebase remains maintainable and ready for growth.
