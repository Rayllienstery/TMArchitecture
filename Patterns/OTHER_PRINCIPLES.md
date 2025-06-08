# Other Principles (Detailed)

## DRY (Don't Repeat Yourself)

Avoid code duplication

- Example: Extract common validation logic into shared utilities
- Reduces maintenance burden
- Ensures consistency
- Improves reliability

**Swift Example:**

```swift
// BAD: Duplicate validation logic
func validateEmail(_ email: String) -> Bool { /* ... */ }
func validateUserEmail(_ email: String) -> Bool { /* ... */ }

// GOOD: Shared utility
func isValidEmail(_ email: String) -> Bool { /* ... */ }
```

## KISS (Keep It Simple, Stupid)

Favor simple solutions

- Example: Use simple data structures over complex ones when possible
- Improves readability
- Reduces bugs
- Eases maintenance

**Swift Example:**

```swift
// BAD: Overcomplicated for a simple counter
class Counter {
    private var value: Int = 0
    func increment() { value += 1 }
    func decrement() { value -= 1 }
    func getValue() -> Int { value }
}

// GOOD: Simple solution
var counter = 0
counter += 1
```

## YAGNI (You Aren't Gonna Need It)

Implement only necessary functionality

- Example: Don't add features until they're actually needed
- Reduces complexity
- Saves development time
- Improves maintainability

**Swift Example:**

```swift
// BAD: Prematurely adding export to XML
struct Report {
    func exportToPDF() { /* ... */ }
    func exportToXML() { /* ... */ } // Not needed yet
}

// GOOD: Only implement what's needed
struct Report {
    func exportToPDF() { /* ... */ }
}
```

## Separation of Concerns (SoC)

Divide application into distinct sections

- Example: Keep UI logic separate from business logic
- Improves maintainability
- Enables parallel development
- Supports testing

**Swift Example:**

```swift
// BAD: View handles business logic
struct ProfileView: View {
    var user: User
    var body: some View {
        Text(user.isActive ? "Active" : "Inactive")
    }
}

// GOOD: ViewModel handles business logic
final class ProfileViewModel {
    let user: User
    var statusText: String { user.isActive ? "Active" : "Inactive" }
    init(user: User) { self.user = user }
}

struct ProfileView: View {
    let model: ProfileViewModel
    var body: some View {
        Text(model.statusText)
    }
}
```

## Composition Over Inheritance

Prefer composition for flexibility

- Example: Use interfaces and composition instead of deep inheritance hierarchies
- Improves flexibility
- Reduces complexity
- Enables better testing

**Swift Example:**

```swift
// BAD: Deep inheritance
class Animal { func speak() {} }
class Dog: Animal { override func speak() { print("Woof") } }
class Cat: Animal { override func speak() { print("Meow") } }

// GOOD: Composition
protocol Speaker { func speak() }
struct Dog: Speaker { func speak() { print("Woof") } }
struct Cat: Speaker { func speak() { print("Meow") } }
```

## Law of Demeter

Modules should know little about other modules

- Example: ViewModel shouldn't know about database implementation details
- Reduces coupling
- Improves maintainability
- Enables better testing

**Swift Example:**

```swift
// BAD: ViewModel accesses database directly
final class UserViewModel {
    func fetchUserName(id: String) -> String? {
        let db = Database()
        return db.queryUser(id: id)?.name
    }
}

// GOOD: ViewModel depends on abstraction
protocol UserRepository {
    func fetchUser(id: String) -> User?
}
final class UserViewModel {
    let repository: UserRepository
    init(repository: UserRepository) { self.repository = repository }
    func fetchUserName(id: String) -> String? {
        repository.fetchUser(id: id)?.name
    }
}
```

## Fail Fast

Detect and report errors early

- Example: Validate input data before processing
- Improves reliability
- Reduces debugging time
- Provides better user experience

**Swift Example:**

```swift
// BAD: No validation, error later
func process(age: Int) {
    // ...
    let years = 100 / age // crash if age == 0
}

// GOOD: Validate early
func process(age: Int) {
    guard age != 0 else { fatalError("Age must not be zero") }
    // ...
}
```

## Principle of Least Astonishment

Code should behave predictably

- Example: Follow platform conventions and common patterns
- Improves usability
- Reduces bugs
- Eases maintenance

**Swift Example:**

```swift
// BAD: Custom button that doesn't look or act like a button
struct WeirdButton: View {
    var body: some View {
        Text("Click me!")
            .onTapGesture { /* ... */ }
    }
}

// GOOD: Use standard Button for expected behavior
Button("Click me!") {
    // ...
}
```
