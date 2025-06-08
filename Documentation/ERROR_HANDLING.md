# Error Handling Guidelines

## Overview

This document outlines the error handling strategy across all layers of the application, ensuring consistent error propagation, user feedback, and recovery mechanisms.

## Error Types

### 1. Domain Errors

```swift
enum DomainError: Error {
    case validation(String)
    case businessRule(String)
    case notFound(String)
    case unauthorized(String)
    case conflict(String)
}
```

### 2. Data Layer Errors

```swift
enum DataError: Error {
    case network(NetworkError)
    case persistence(PersistenceError)
    case mapping(MappingError)
    case unknown(Error)
}

enum NetworkError: Error {
    case noConnection
    case timeout
    case serverError(Int)
    case invalidResponse
}

enum PersistenceError: Error {
    case saveFailed
    case loadFailed
    case deleteFailed
    case migrationFailed
}
```

### 3. Presentation Errors

```swift
enum PresentationError: Error {
    case invalidInput(String)
    case displayError(String)
    case navigationError(String)
}

// New type for user-facing errors
struct UserFacingError: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    let action: ErrorAction?
    
    struct ErrorAction {
        let title: String
        let handler: () -> Void
    }
    
    static func from(_ error: Error) -> UserFacingError {
        switch error {
        case let domainError as DomainError:
            return mapDomainError(domainError)
        case let dataError as DataError:
            return mapDataError(dataError)
        case let presentationError as PresentationError:
            return mapPresentationError(presentationError)
        default:
            let nsError = error as NSError
            return UserFacingError(
                title: nsError.domain,
                message: nsError.localizedDescription,
                action: ErrorAction(
                    title: "Try Again",
                    handler: { /* Retry logic */ }
                )
            )
        }
    }
    
    private static func mapDomainError(_ error: DomainError) -> UserFacingError {
        switch error {
        case .validation(let message):
            return UserFacingError(
                title: "Validation Error",
                message: message,
                action: nil
            )
        case .unauthorized(let message):
            return UserFacingError(
                title: "Access Denied",
                message: message,
                action: ErrorAction(
                    title: "Sign In",
                    handler: { /* Navigate to sign in */ }
                )
            )
        case .businessRule(let message):
            return UserFacingError(
                title: "Cannot Proceed",
                message: message,
                action: ErrorAction(
                    title: "Learn More",
                    handler: { /* Show help */ }
                )
            )
        case .notFound(let message):
            return UserFacingError(
                title: "Not Found",
                message: message,
                action: ErrorAction(
                    title: "Go Back",
                    handler: { /* Navigate back */ }
                )
            )
        case .conflict(let message):
            return UserFacingError(
                title: "Conflict",
                message: message,
                action: ErrorAction(
                    title: "Resolve",
                    handler: { /* Show resolution options */ }
                )
            )
        }
    }
    
    private static func mapDataError(_ error: DataError) -> UserFacingError {
        switch error {
        case .network(let networkError):
            return mapNetworkError(networkError)
        case .persistence(let persistenceError):
            return mapPersistenceError(persistenceError)
        case .mapping:
            return UserFacingError(
                title: "Data Error",
                message: "Unable to process data",
                action: ErrorAction(
                    title: "Try Again",
                    handler: { /* Retry logic */ }
                )
            )
        case .unknown:
            return UserFacingError(
                title: "System Error",
                message: "Please try again later",
                action: ErrorAction(
                    title: "Try Again",
                    handler: { /* Retry logic */ }
                )
            )
        }
    }
    
    private static func mapNetworkError(_ error: NetworkError) -> UserFacingError {
        switch error {
        case .noConnection:
            return UserFacingError(
                title: "No Connection",
                message: "Please check your internet connection",
                action: ErrorAction(
                    title: "Retry",
                    handler: { /* Retry logic */ }
                )
            )
        case .timeout:
            return UserFacingError(
                title: "Connection Timeout",
                message: "The request took too long to complete",
                action: ErrorAction(
                    title: "Try Again",
                    handler: { /* Retry logic */ }
                )
            )
        case .serverError(let code):
            return UserFacingError(
                title: "Server Error",
                message: "Please try again later (Error \(code))",
                action: ErrorAction(
                    title: "Try Again",
                    handler: { /* Retry logic */ }
                )
            )
        case .invalidResponse:
            return UserFacingError(
                title: "Invalid Response",
                message: "Received invalid data from server",
                action: ErrorAction(
                    title: "Try Again",
                    handler: { /* Retry logic */ }
                )
            )
        }
    }
    
    private static func mapPersistenceError(_ error: PersistenceError) -> UserFacingError {
        switch error {
        case .saveFailed:
            return UserFacingError(
                title: "Save Failed",
                message: "Unable to save your changes",
                action: ErrorAction(
                    title: "Try Again",
                    handler: { /* Retry logic */ }
                )
            )
        case .loadFailed:
            return UserFacingError(
                title: "Load Failed",
                message: "Unable to load your data",
                action: ErrorAction(
                    title: "Try Again",
                    handler: { /* Retry logic */ }
                )
            )
        case .deleteFailed:
            return UserFacingError(
                title: "Delete Failed",
                message: "Unable to delete the item",
                action: ErrorAction(
                    title: "Try Again",
                    handler: { /* Retry logic */ }
                )
            )
        case .migrationFailed:
            return UserFacingError(
                title: "Update Required",
                message: "Please update the app to continue",
                action: ErrorAction(
                    title: "Update",
                    handler: { /* Open App Store */ }
                )
            )
        }
    }
    
    private static func mapPresentationError(_ error: PresentationError) -> UserFacingError {
        switch error {
        case .invalidInput(let message):
            return UserFacingError(
                title: "Invalid Input",
                message: message,
                action: nil
            )
        case .displayError(let message):
            return UserFacingError(
                title: "Display Error",
                message: message,
                action: ErrorAction(
                    title: "Try Again",
                    handler: { /* Retry logic */ }
                )
            )
        case .navigationError(let message):
            return UserFacingError(
                title: "Navigation Error",
                message: message,
                action: ErrorAction(
                    title: "Go Back",
                    handler: { /* Navigate back */ }
                )
            )
        }
    }
}
```

## Error Handling Strategy

### 1. Domain Layer

- Define clear, specific error types for business rule violations
- Use descriptive error messages
- Include error codes for programmatic handling
- Document error scenarios in use cases

Example:

```swift
struct CreateUserUseCase {
    func execute(_ user: User) async throws {
        guard !user.email.isEmpty else {
            throw DomainError.validation("Email cannot be empty")
        }
        guard user.password.count >= 8 else {
            throw DomainError.validation("Password must be at least 8 characters")
        }
        // ... rest of the logic
    }
}
```

### 2. Data Layer

- Map external errors to domain errors
- Implement retry logic for transient failures
- Handle network and persistence errors appropriately
- Log errors for debugging

Example:

```swift
class UserRepositoryImpl: UserRepository {
    func save(_ user: User) async throws {
        do {
            try await database.save(user)
        } catch let error as DatabaseError {
            switch error {
            case .connectionFailed:
                throw DataError.network(.noConnection)
            case .constraintViolation:
                throw DomainError.conflict("User already exists")
            default:
                throw DataError.persistence(.saveFailed)
            }
        }
    }
}
```

### 3. Presentation Layer

- Handle domain and data errors appropriately
- Provide user-friendly error messages
- Implement error recovery mechanisms
- Show appropriate UI feedback

Example:

```swift
@Observable final class LoginViewModel {
    var error: UserFacingError?
    var isLoading = false
    
    func login(email: String, password: String) async {
        isLoading = true
        error = nil
        
        do {
            try await loginUseCase.execute(email: email, password: password)
        } catch {
            error = UserFacingError.from(error)
        }
        
        isLoading = false
    }
}

struct LoginView: View {
    let model: LoginViewModel
    
    var body: some View {
        VStack {
            // Login form fields
            
            if let error = model.error {
                ErrorView(error: error)
            }
        }
    }
}

/// A reusable component for displaying user-facing errors with optional actions.
struct ErrorView: View {
    let error: UserFacingError
    
    var body: some View {
        VStack(spacing: 16) {
            Text(error.title)
                .font(.headline)
            
            Text(error.message)
                .font(.body)
            
            if let action = error.action {
                Button(action.title) {
                    action.handler()
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}
```

## Error Recovery Strategies

### 1. Automatic Recovery

- Implement retry logic for transient failures
- Use exponential backoff for network requests
- Cache data for offline access
- Handle session expiration

### 2. User-Driven Recovery

- Provide clear error messages
- Offer retry options
- Suggest alternative actions
- Guide users through error resolution

## Best Practices

1. **Error Propagation**
   - Always use typed errors
   - Don't swallow errors
   - Transform errors at layer boundaries
   - Maintain error context

2. **Error Logging**
   - Log all errors with appropriate severity
   - Include relevant context
   - Don't log sensitive information
   - Use structured logging
   - Use centralized logger for critical paths (e.g., `AppLogger.log(error, context:)`)
   - Avoid logging user identifiers or sensitive fields

    ```swift
    // ❌ Bad
    AppLogger.log("Login failed for user: \(email)")

    // ✅ Good
    AppLogger.log("Login failed due to invalid credentials")
    ```

3. **User Feedback**
   - Show clear, actionable error messages
   - Provide recovery options
   - Use appropriate UI components
   - Consider accessibility

4. **Testing**
   - Test error scenarios
   - Verify error messages
   - Test recovery mechanisms
   - Mock error conditions
5. **User-Facing Error Mapping**
   - Unit test `UserFacingError.from(error)` with different error inputs
   - Validate `title`, `message`, and presence/absence of `action`

## Example Implementation

### Error Handling in Use Case

```swift
struct TransferMoneyUseCase {
    func execute(amount: Decimal, from: Account, to: Account) async throws {
        // Validate input
        guard amount > 0 else {
            throw DomainError.validation("Amount must be positive")
        }
        
        // Check business rules
        guard from.balance >= amount else {
            throw DomainError.businessRule("Insufficient funds")
        }
        
        // Execute transfer
        do {
            try await accountRepository.transfer(amount: amount, from: from, to: to)
        } catch let error as DataError {
            switch error {
            case .network:
                throw DomainError.businessRule("Transfer failed due to network issues")
            case .persistence:
                throw DomainError.businessRule("Transfer failed due to system error")
            default:
                throw DomainError.businessRule("Transfer failed")
            }
        }
    }
}
```

### Error Handling in ViewModel

```swift
@Observable final class TransferViewModel {
    var errorMessage: String?
    var isLoading = false
    
    func transfer(amount: String, from: Account, to: Account) async {
        isLoading = true
        errorMessage = nil
        
        do {
            guard let amountDecimal = Decimal(string: amount) else {
                throw PresentationError.invalidInput("Invalid amount format")
            }
            
            try await transferUseCase.execute(amount: amountDecimal, from: from, to: to)
        } catch let error as DomainError {
            errorMessage = error.localizedDescription
        } catch let error as PresentationError {
            errorMessage = error.localizedDescription
        } catch {
            errorMessage = "An unexpected error occurred"
        }
        
        isLoading = false
    }
}
```

## Common Anti-Patterns to Avoid

1. **Swallowing Errors**

   ```swift
   // ❌ Bad
   try? someOperation()
   
   // ✅ Good
   do {
       try someOperation()
   } catch {
       handleError(error)
   }
   ```

2. **Generic Error Messages**

   ```swift
   // ❌ Bad
   throw Error("Something went wrong")
   
   // ✅ Good
   throw DomainError.validation("Amount must be positive")
   ```

3. **Error Type Casting**

   ```swift
   // ❌ Bad
   if let error = error as? SomeError {
       // handle error
   }
   
   // ✅ Good
   switch error {
   case let domainError as DomainError:
       handleDomainError(domainError)
   case let dataError as DataError:
       handleDataError(dataError)
   default:
       handleUnknownError(error)
   }
   ```

4. **Ignoring Error Context**

   ```swift
   // ❌ Bad
   throw Error("Failed")
   
   // ✅ Good
   throw DomainError.businessRule("Transfer failed: Insufficient funds in account \(accountId)")
   ```
