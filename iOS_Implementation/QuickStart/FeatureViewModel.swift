import SwiftUI

protocol FeatureViewModel: AnyObject, Observable {

  var viewData: FeatureViewData? { get }

  func updateEntity()
}

@Observable
final class FeatureViewModelImpl: FeatureViewModel {
  private let useCase: FeatureGetUseCase

  private var entity: FeatureEntity? {
    didSet {
      updateViewData()
    }
  }

  private(set) var viewData: FeatureViewData?

  init(useCase: FeatureGetUseCase) {
    self.useCase = useCase

    Task {
      updateEntity()
    }
  }

  func updateEntity() {
    self.entity = useCase.getEntity()
  }

  private func updateViewData() {
    guard let entity = entity else {
      viewData = nil
      return
    }
    viewData = FeatureViewData(entity: entity)
  }
}
