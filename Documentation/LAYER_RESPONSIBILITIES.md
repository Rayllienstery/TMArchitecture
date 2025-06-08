# Layer Responsibilities and Anti-Patterns

> For a brief overview of each layer, see [ARCHITECTURE.md](ARCHITECTURE.md#layer-overview).

## Layer Responsibilities

### Presentation Layer

**Responsibilities:**

- UI rendering (what user sees on screen)
- User interaction (handling button clicks, form inputs, etc.)
- ViewModels for state management and business logic coordination
- Navigation flow management (using Coordinators or other routing mechanisms)
  - For detailed navigation architecture, see [NAVIGATION.md](NAVIGATION.md)

**Best Practices:**

- Use appropriate state management patterns for your platform
- Pass ViewModels as dependencies to views
- Use custom UI components and reusable elements
- Implement proper error handling and user feedback
- Follow platform-specific design guidelines
- Ensure accessibility compliance
- Optimize performance for smooth user experience

### Application Layer (optional)

**Responsibilities:**

- Coordinate complex workflows, transactions, and integration between multiple use cases or external systems
- Orchestrate domain operations, handle commands, queries, and events
- Compose and manage application services, command/query handlers, event handlers, DTO/mappers
- Integrate with external systems, APIs, or services (e.g., payment gateways, messaging, third-party authentication)
- Implement CQRS, Sagas, distributed transactions if needed

**Key Components:**

- **Application Services:** Coordinate use case execution, manage transactions, workflows
- **Command Handlers:** Handle commands, initiate domain actions
- **Query Handlers:** Handle data read requests
- **Event Handlers:** React to domain or integration events
- **DTO/Mappers:** Transform data between layers

**Best Practices:**

- Use this layer only if your business logic or integration complexity justifies it
- Keep orchestration logic here, not business rules
- Use dependency injection to compose workflows and inject new behaviors
- Organize code by feature or workflow for clarity and scalability
- Follow SOLID principles when adding new use cases, commands, or events
- Add new workflows or integrations by introducing new handlers/services, not by modifying existing ones

**Advanced Patterns:**

- CQRS (Command Query Responsibility Segregation)
- Saga (Process Manager)

**Further Reading:**

- [Microsoft Docs: Application Layer in DDD](https://learn.microsoft.com/en-us/azure/architecture/guide/architecture-styles/domain-driven-design)
- [CQRS Pattern (Microsoft)](https://learn.microsoft.com/en-us/azure/architecture/patterns/cqrs)
- [Saga Pattern (Microsoft)](https://learn.microsoft.com/en-us/azure/architecture/reference-architectures/saga/saga)

### Domain Layer

**Responsibilities:**

- Contains the core business logic and rules of the application
- Defines application-specific use cases (interactors)
- Specifies core data structures (entities)
- Defines contracts (protocols/interfaces) for data repositories
- Manages domain-specific errors
- Handles business rules validation
- Manages domain events and their handlers

**Key Components:**

- **Entities:** Plain data structures representing core concepts
  _Example:_

  ```swift
  struct Task {
      let id: UUID
      var title: String
      var isCompleted: Bool
      var dueDate: Date
      func validate() throws {
          guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
              throw TaskValidationError("Title cannot be empty")
          }
          guard dueDate >= Date() else {
              throw TaskValidationError("Due date cannot be in the past")
          }
      }
  }
  ```

- **Use Cases (Interactors):** Classes responsible for executing specific business operations
  _Example:_ `CreateTaskUseCase`, `CompleteTaskUseCase`, `GetTasksUseCase`
- **Repository Protocols:** Define the interfaces for data access operations
  _Example:_

  ```swift
  protocol TaskRepository {
      func getTasks() async throws -> [Task]
      func getTask(by id: UUID) async throws -> Task
      func createTask(_ task: Task) async throws
      func updateTask(_ task: Task) async throws
      func deleteTask(id: UUID) async throws
  }
  ```

- **Domain Errors:** Custom error types representing specific business rule violations
  _Example:_ `TaskValidationError`, `TaskNotFoundError`
- **Domain Events:** Represent significant occurrences in the domain
  _Example:_ `TaskCreatedEvent`, `TaskCompletedEvent`

**Best Practices:**

- This layer must NOT depend on any UI framework or specific data storage implementation
- Business logic within Use Cases should be thoroughly unit tested
- Encapsulate distinct business rules within specific Use Cases
- Implement comprehensive input validation
- Define clear error types and handling strategies
- Document complex business rules and requirements

**Advanced Patterns:**

- Event Sourcing, Domain Events, DDD patterns (see Further Reading)

**Further Reading:**

- [Domain-Driven Design Reference (Evans)](https://domainlanguage.com/ddd/reference/)
- [Clean Architecture (Uncle Bob)](https://8thlight.com/blog/uncle-bob/2012/08/13/the-clean-architecture.html)

### Data Layer

**Responsibilities:**

- Implements data access, persistence, and integration with external systems
- Provides concrete implementations of repository interfaces
- Handles data mapping, caching, and error handling for infrastructure concerns
- Data sources (network, local storage, external services)
- Data mapping and transformation
- Caching and data persistence
- Error handling and retry logic
- Data synchronization

**Key Components:**

- **Repositories:** Abstract data access operations
  _Example:_ `UserRepositoryImpl`, `OrderRepositoryImpl`
- **DataSources:** Concrete implementation for specific data sources
  _Example:_ `RESTAPIClient`, `LocalDatabase`, `FileStorage`
- **Mappers:** Data transformation between DTOs and domain models
  _Example:_ `UserDTOtoEntityMapper`, `OrderEntityToDTOMapper`
- **DTOs:** Data Transfer Objects for network/database
- **Persistence:** CoreData, SwiftData or other persistence logic

**Best Practices:**

- Use repositories to abstract data sources
- Implement dependency injection for testability
- Handle network errors gracefully
- Implement proper caching strategies
- Ensure data consistency
- Monitor performance and resource usage

**Advanced Patterns:**

- Data synchronization, caching strategies, retry logic

**Further Reading:**

- [Repository Pattern (Martin Fowler)](https://martinfowler.com/eaaCatalog/repository.html)
- [Data Mapper Pattern (Martin Fowler)](https://martinfowler.com/eaaCatalog/dataMapper.html)

---

## Summary

- Keep business rules in the Domain layer.
- Use Application layer for orchestration only when justified.
- Keep Presentation and Data layers focused on their respective concerns.
- Avoid mixing responsibilities to maintain a clean, maintainable, and testable architecture.

> **See anti-patterns:** [ANTI_PATTERNS.md](../Patterns/ANTI_PATTERNS.md)
