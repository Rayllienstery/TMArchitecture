import SwiftUI
import TMNavigation

// MARK: - Environment Key
private struct CoordinatorKey: EnvironmentKey {
  @MainActor
  static var defaultValue: TMCoordinator<AppWaypoint> {
    TMCoordinator<AppWaypoint>()
  }
}

extension EnvironmentValues {
  var coordinator: TMCoordinator<AppWaypoint> {
    get { self[CoordinatorKey.self] }
    set { self[CoordinatorKey.self] = newValue }
  }
}
