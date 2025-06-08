import SwiftUI
import TMNavigation

enum AppWaypoint: TMWaypoint, Identifiable {
  var id: Self { self }

  case feature(FeatureViewFactory)

  func view(coordinator: any TMNavigation.TMCoordinatorProtocol) -> AnyView {
    switch self {
    case .feature(let factory): .init(factory.view())
    }
  }

  static func == (lhs: AppWaypoint, rhs: AppWaypoint) -> Bool {
    lhs.hashValue == rhs.hashValue
  }

  func hash(into hasher: inout Hasher) {
    switch self {
    case .feature(let factory):
      hasher.combine(factory)
    }
  }

}
