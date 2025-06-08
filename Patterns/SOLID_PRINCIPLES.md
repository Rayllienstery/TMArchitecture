# SOLID Principles (Detailed)

## Single Responsibility Principle (SRP)

Each type has one responsibility

- Example: UserRepository only handles user data operations
- Promotes maintainability
- Reduces complexity
- Improves testability

**Swift Example:**

```swift
import os

// BAD: Violates SRP (handles both data and logging)
final class UserRepository {
    private let logger = Logger(subsystem: "com.example.app", category: "UserRepository")
    func save(user: User) {
        // Save user to database
        logger.log("User saved: \(user.name)") // Logging responsibility
    }
}

// GOOD: Each class has a single responsibility
final class UserRepository {
    func save(user: User) {
        // Save user to database
    }
}

final class LogService {
    private let logger = Logger(subsystem: "com.example.app", category: "General")
    func log(_ message: String) {
        logger.log("\(message)")
    }
}
```

## Open/Closed Principle (OCP)

Code is open for extension but closed for modification

- Example: Adding new payment methods without changing existing code
- Enables feature extension
- Reduces regression risk
- Promotes reuse

**Swift Example:**

```swift
// BAD: Adding new payment methods requires modifying the enum and switch
enum PaymentType {
    case creditCard, paypal
}

func process(payment: PaymentType) {
    switch payment {
    case .creditCard: /* ... */
    case .paypal: /* ... */
    }
}

// GOOD: Use protocol for extensibility
protocol PaymentMethod {
    func process()
}

struct CreditCard: PaymentMethod {
    func process() { /* ... */ }
}

struct PayPal: PaymentMethod {
    func process() { /* ... */ }
}

func process(payment: PaymentMethod) {
    payment.process()
}
```

## Liskov Substitution Principle (LSP)

Subtypes are substitutable for base types

- Example: Any implementation of UserRepository can be used where UserRepository is expected
- Ensures type safety
- Enables polymorphism
- Supports testing

**Swift Example:**

```swift
protocol UserRepository {
    func fetchUser(id: String) -> User?
}

final class LocalUserRepository: UserRepository {
    func fetchUser(id: String) -> User? { /* ... */ return nil }
}

final class RemoteUserRepository: UserRepository {
    func fetchUser(id: String) -> User? { /* ... */ return nil }
}

func printUserName(repo: UserRepository, id: String) {
    if let user = repo.fetchUser(id: id) {
        print(user.name)
    }
}
// Both LocalUserRepository and RemoteUserRepository can be used here
```

## Interface Segregation Principle (ISP)

Small, specific interfaces over large ones

- Example: Separate ReadOnlyRepository and WritableRepository interfaces
- Reduces coupling
- Improves maintainability
- Enables better testing

**Swift Example:**

```swift
// BAD: One big protocol
protocol Repository {
    func fetch(id: String) -> User?
    func save(user: User)
}

// GOOD: Segregated interfaces
protocol ReadOnlyRepository {
    func fetch(id: String) -> User?
}

protocol WritableRepository {
    func save(user: User)
}

final class UserRepository: ReadOnlyRepository, WritableRepository {
    func fetch(id: String) -> User? { /* ... */ return nil }
    func save(user: User) { /* ... */ }
}
```

## Dependency Inversion Principle (DIP)

High-level modules depend on abstractions

- Example: ViewModel depends on Repository interface, not concrete implementation
- Enables loose coupling
- Improves testability
- Supports modularity

**Swift Example:**

```swift
// BAD: ViewModel depends on concrete repository
final class UserViewModel {
    private let repository = UserRepository()
}

// GOOD: ViewModel depends on abstraction
protocol UserRepository {
    func fetchUser(id: String) -> User?
}

final class UserViewModel {
    private let repository: UserRepository
    init(repository: UserRepository) {
        self.repository = repository
    }
}
```
