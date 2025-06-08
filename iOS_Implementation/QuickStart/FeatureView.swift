import SwiftUI
import TMNavigation

struct FeatureView<ViewModel: FeatureViewModel>: View {
  @Bindable var model: ViewModel

  init(model: ViewModel) {
    self.model = model
  }

  var body: some View {
    VStack {
      Text("Feature View")

      if let viewData = model.viewData {
        Text("Name: \(viewData.name)")
        if let description = viewData.description {
          Text("Description: \(description)")
        }
      }

      Button("Update") {
        model.updateEntity()
      }
    }
  }
}

struct FeatureViewFactory: Hashable {
  var type: FactoryType

  func view() -> AnyView {
    switch type {
    case .impl:
      AnyView(impl())
    }
  }

  @ViewBuilder
  private func impl() -> some View {
    let repository = FeatureRepositoryImpl()
    let useCase = FeatureGetUseCaseImpl(repository: repository)
    let viewModel = FeatureViewModelImpl(useCase: useCase)
    FeatureView(model: viewModel)
  }

  enum FactoryType {
    case impl
  }
}
