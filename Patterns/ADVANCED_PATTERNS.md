# Optional Advanced Patterns

This document outlines optional architectural patterns that extend the base TMArchitecture. These patterns are intended for large-scale or enterprise systems and should be used only when the complexity of the project justifies their inclusion. For most apps, the base architecture (Clean Architecture + MVVM) is sufficient.

---

## CQRS (Command Query Responsibility Segregation)

- **Purpose:** Separate models and handlers for commands (write operations) and queries (read operations).
- **When to use:**
  - Complex business processes
  - High load on reads and writes
  - Need for independent scaling of read/write
- **Structure:**
  - `Application/Commands/` — Command handlers (write)
  - `Application/Queries/` — Query handlers (read)

    ```swift
    // Command
    Application/Commands/UpdateProfileCommand.swift

    // Query
    Application/Queries/GetUserProfileQuery.swift
    ```

- **Note:** For most mobile apps, CQRS is overkill. Use only if justified by business complexity.

---

## Event Sourcing

- **Purpose:** Store all changes to application state as a sequence of events, not just the current state.
- **When to use:**
  - Full audit/history is required
  - Need to replay or rollback state
  - Complex workflows with many state transitions
- **Structure:**
  - `Domain/Events/` — Domain events
  - `Data/EventStore/` — Event storage and replay

    ```swift
    // Domain Event
    Domain/Events/UserProfileUpdated.swift

    // Event Store
    Data/EventStore/EventStoreService.swift
    ```

- **Note:** Adds significant complexity. Use only for systems with strict audit or rollback requirements.

---

## Saga (Process Manager)

- **Purpose:** Manage long-running, distributed, or multi-step business processes and transactions.
- **When to use:**
  - Orchestration of multiple services/use cases
  - Need for compensation/rollback logic
  - Distributed transactions
- **Structure:**
  - `Application/Services/` — Saga orchestrators/process managers

    ```swift
    // Saga Orchestrator
    Application/Services/UserRegistrationSaga.swift
    ```

- **Note:** Rarely needed in classic mobile apps. Consider only for enterprise or distributed systems.

---

## Integration Tips

These advanced patterns can be integrated into your TMArchitecture setup as follows:

- **CQRS** can replace or extend the UseCase layer, separating read and write logic into Queries and Commands.
- **Event Sourcing** replaces traditional repository logic with append-only event streams.
- **Sagas** coordinate multiple UseCases or external services and can be hosted inside the Application layer.

Use each only if the business case requires it.

---

**Summary:**

- These patterns are not required for regular applications.
- Consider them only if your project is truly enterprise-level, with high complexity, integrations, audit, and scalability requirements.
- In all other cases, stick to the basic architecture for simplicity and maintainability.
