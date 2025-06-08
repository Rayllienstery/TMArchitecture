# Dependency Injection Guidelines

Dependency Injection is implemented throughout the application to support the Dependency Inversion Principle (DIP) from SOLID. Instead of having a separate directory, DI is integrated into each layer:

## Presentation Layer

- ViewModels receive their dependencies through constructor injection
- Views receive their ViewModels through constructor injection
- Navigation dependencies are injected where needed

## Domain Layer

- Use Cases receive their repository dependencies through constructor injection
- Domain Services receive their dependencies through constructor injection

## Data Layer

- Repositories receive their data source dependencies through constructor injection
- Services receive their external dependencies through constructor injection

## App Layer

- The application's root container is configured here
- Global dependencies are registered
- Feature-specific containers are composed

This approach:

- Maintains clean architecture principles
- Keeps dependencies explicit
- Improves testability
- Supports modularity
- Enables better separation of concerns
