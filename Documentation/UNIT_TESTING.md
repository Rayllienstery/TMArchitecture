# Unit Testing Guidelines

## Overview

This document outlines universal standards and best practices for writing unit tests in any technology stack. The goal is to ensure comprehensive, reliable, and maintainable test coverage for all critical components.

## Table of Contents

1. General Requirements
2. Test Structure
3. Naming Conventions
4. Testing Different Layers
5. Mocking and Test Doubles
6. Code Coverage
7. Best Practices
8. Asynchronous and Multithreaded Testing
9. UI and End-to-End Testing
10. Performance and Security Testing
11. CI/CD Integration
12. Test Maintenance and Evolution
13. Anti-Patterns
14. Examples

## General Requirements

- Each test file should contain only one test suite.
- Test files should mirror the structure of the main source code.
- All non-test code (mocks, test doubles, helpers) should be placed in a dedicated support folder.
- Each mock/test double/helper file should declare only one class/interface/struct.
- Tests must be independent and not rely on the state from other tests.
- Tests should be fast and reliable.
- Use appropriate test categories (unit, integration, UI, E2E, performance, security) based on what's being tested.

## Test Structure

- Follow the **Given-When-Then** (Arrange-Act-Assert) pattern for all tests.
- Each test should clearly set up the context, perform the action, and verify the result.

**Example (Pseudocode):**

``` text
Test: should return correct result when valid input is provided
  Given: a valid input
  When: the function is called
  Then: the expected result is returned
```

``` text
Test: should throw error when input is invalid
  Given: an invalid input
  When: the function is called
  Then: an error is thrown
```

## Naming Conventions

- Test suite names should match the class/component/module being tested.
- Test method names should describe the expected behavior and the condition.
- Recommended pattern: `should <expected behavior> when <condition>`

## Testing Different Layers

- **Domain Layer:** Focus on business logic and rules.
- **Presentation Layer:** Test view models, UI logic, and state changes.
- **Data Layer:** Test repositories, data sources, and data transformation.
- **Application Layer:** Test orchestration, workflows, and integration between use cases.

## Mocking and Test Doubles

- All mocks and test doubles should be placed in a dedicated support directory.
- Each mock class/struct should be in its own file.
- Mocks should implement the same interface/protocol as the class they are mocking.
- The file and folder structure for mocks should mirror the main source code.

**Types of Test Doubles:**

- **Mock:** Verifies interactions (e.g., method calls, arguments).
- **Stub:** Provides canned answers to calls made during the test.
- **Fake:** Has a working implementation, but is simplified (e.g., in-memory DB).
- **Spy:** Records information about calls, can be queried after the test.
- **Dummy:** Passed around but never used (just to fill parameter lists).

**When to use:**

- Use mocks for verifying behavior/interactions.
- Use stubs/fakes for isolating dependencies and controlling test data.
- Use dummies for required but unused parameters.

## Code Coverage

- Set clear coverage goals for each layer (e.g., 80%+ for business logic, 50%+ for view models, critical paths for UI).
- Use coverage reports to identify untested code.
- Prioritize testing of business-critical paths, edge cases, and error conditions.
- Review coverage reports regularly and address gaps.
- Integrate coverage checks into CI/CD pipelines.

## Best Practices

1. **Test Independence**
   - Each test should be independent and not rely on the execution order.
   - Clean up after each test.

2. **Test Readability**
   - Use clear, descriptive test names.
   - Follow the Given-When-Then pattern.
   - Add comments for complex scenarios.

3. **Test Maintainability**
   - Keep tests simple and focused.
   - Use helper methods for common setup.
   - Extract complex test data into separate files.

4. **Error Testing**
   - Test both success and failure cases.
   - Verify error messages and types.
   - Test edge cases and boundary conditions.

5. **Async Testing**
   - Use appropriate async testing patterns for your language/framework.
   - Handle timeouts and cancellation.
   - Test both success and error scenarios.

6. **Test Data Management**
   - Use factories/builders for complex test data.
   - Avoid hardcoding large data sets in test files.

## Asynchronous and Multithreaded Testing

- Use language/framework-specific tools for testing async code (e.g., async/await, promises, callbacks, futures).
- Test both success and failure paths for async operations.
- Use timeouts and cancellation to avoid hanging tests.
- For multithreaded code, test for race conditions, deadlocks, and thread safety.
- Use stress tests and randomized scheduling where possible.

**Pseudocode Example:**

``` text
Test: should complete operation within timeout
  Given: an async operation
  When: the operation is started
  Then: it completes within the expected time
```

## UI and End-to-End Testing

- Use UI/E2E tests to verify critical user flows and integration between components.
- Automate UI tests where possible (e.g., Selenium, Appium, XCUITest, Espresso).
- Test accessibility features (labels, hints, navigation).
- Use snapshot/screenshot testing for visual regressions.
- Run UI/E2E tests in CI/CD pipelines.

## Performance and Security Testing

- Include performance tests for critical paths (e.g., response time, memory usage).
- Use load/stress tests to identify bottlenecks.
- Include security tests (e.g., input validation, authentication, authorization, vulnerability scanning).
- Automate performance and security tests where possible.

## CI/CD Integration

- Automate test execution in CI/CD pipelines for every commit and pull request.
- Fail builds on test or coverage failures.
- Generate and publish test and coverage reports.
- Use parallelization and caching to speed up test runs.
- Integrate with code review tools for test status feedback.

## Test Maintenance and Evolution

- Regularly review and refactor tests for readability and maintainability.
- Remove or update obsolete and flaky tests.
- Track test coverage and quality metrics over time.
- Document test strategies, coverage goals, and known gaps.
- Encourage code reviews for test code as for production code.

## Anti-Patterns

- **Flaky Tests:** Tests that pass/fail non-deterministically.
- **Over-Mocking:** Excessive use of mocks leading to brittle tests.
- **Test Interdependence:** Tests that depend on the state or order of other tests.
- **Testing Implementation, Not Behavior:** Tying tests to internal details instead of public API/contract.
- **Ignoring Edge Cases:** Not testing boundaries, error conditions, or unusual inputs.
- **Slow Tests:** Tests that take too long and slow down feedback cycles.
- **Unmaintained Tests:** Outdated, ignored, or commented-out tests.

## Examples

**Pseudocode Example:**

``` text
Test: should return correct result when valid input is provided
  Given: a valid input
  When: the function is called
  Then: the expected result is returned
```

``` text
Test: should throw error when input is invalid
  Given: an invalid input
  When: the function is called
  Then: an error is thrown
```

``` text
Test: should complete async operation successfully
  Given: an async function
  When: it is called with valid input
  Then: it resolves with the expected result
```

## Testing the Application Layer

- Focus on testing orchestration logic, workflow coordination, and integration between use cases.
- Write unit tests for Application Services, Command Handlers, Query Handlers, and Event Handlers.
- Use mocks or fakes for domain use cases and repositories to isolate orchestration logic.
- Write integration tests to verify end-to-end workflows and interactions with external systems.

**Example (Pseudocode):**

``` text
Test: should orchestrate onboarding workflow
  Given: valid user data and mocked domain use cases
  When: onboarding service is called
  Then: all required use cases are invoked in correct order
  And: external system is notified
```

## Error Handling & Transaction Management

- Test that the Application Layer correctly handles errors from domain and data layers.
- Verify that transactions are committed or rolled back as expected.
- Test compensation logic for Sagas or distributed transactions.
- Ensure that errors are propagated or logged according to business requirements.

**Example (Pseudocode):**

``` text
Test: should rollback transaction on failure
  Given: a multi-step workflow with a failing step
  When: the workflow is executed
  Then: all previous steps are rolled back
  And: error is reported to the caller
```

``` text
Test: should handle domain error gracefully
  Given: a domain use case that throws a validation error
  When: the application service is called
  Then: the error is caught and a user-friendly message is returned
```
