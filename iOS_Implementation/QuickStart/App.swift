import SwiftUI
import TMNavigation

@main
struct TMArchitectureMinumumSetupApp: App {
  @Bindable var coordinator = TMCoordinator<AppWaypoint>()

  var body: some Scene {
    WindowGroup {
      AppWaypoint.feature(.init(type: .impl)).view(coordinator: coordinator)
        .environment(\.coordinator, coordinator)
    }
  }
}
