# Anti-Patterns

> For a brief overview of layers, see [Documentation/ARCHITECTURE.md](../Documentation/ARCHITECTURE.md#layer-overview).
> For detailed responsibilities, see [Documentation/LAYER_RESPONSIBILITIES.md](../Documentation/LAYER_RESPONSIBILITIES.md).

## Presentation Layer

- **Direct Data Access from Presentation Layer:**
  - Anti-pattern: UI or ViewModels directly accessing data sources or repositories.
  - Consequence: Tight coupling, poor testability, and broken separation of concerns.
  - Recommendation: Always delegate data access to the Domain layer via ViewModels and UseCases.

## Application Layer

- **Business Logic in Application Layer:**
  - Anti-pattern: Placing core business rules or validation in Application Services instead of UseCases or Entities.
  - Consequence: Harder to test, maintain, and evolve business logic; violates Clean Architecture.
  - Recommendation: Keep orchestration in Application layer, business rules in Domain layer.

- **Infrastructure Logic in Application Layer:**
  - Anti-pattern: Handling persistence, networking, or external API calls in Application Services.
  - Consequence: Increases coupling, reduces portability, and violates dependency inversion.
  - Recommendation: Use repositories and domain interfaces for all data access.

## Domain Layer

- **Orchestration in Domain Layer:**
  - Anti-pattern: Placing workflow, transaction, or integration logic in UseCases or Entities.
  - Consequence: Domain layer becomes bloated and less reusable.
  - Recommendation: Keep orchestration in Application layer.

- **Infrastructure Logic in Domain Layer:**
  - Anti-pattern: Handling persistence, networking, or external API calls in Domain layer.
  - Consequence: Violates dependency inversion, increases coupling, and reduces portability.
  - Recommendation: Domain layer should be pure and framework-agnostic.

## Data Layer

- **Business Logic in Data Layer:**
  - Anti-pattern: Implementing business rules or validation in repositories or data sources.
  - Consequence: Business logic becomes fragmented and hard to maintain.
  - Recommendation: Keep business rules in Domain layer; Data layer should only handle data access and mapping.

---

## Summary

- Avoid mixing responsibilities between layers.
- Keep each layer focused on its core purpose.
- For more details, see [Documentation/LAYER_RESPONSIBILITIES.md](../Documentation/LAYER_RESPONSIBILITIES.md).

> All comments and documentation in this file follow the English-only convention for consistency across the project.
