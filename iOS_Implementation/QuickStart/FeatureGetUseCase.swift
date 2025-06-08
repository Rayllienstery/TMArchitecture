import Foundation

protocol FeatureGetUseCase {
  func getEntity() -> FeatureEntity
}

final class FeatureGetUseCaseImpl: FeatureGetUseCase {
  private let repository: FeatureRepository

  init(repository: FeatureRepository) {
    self.repository = repository
  }

  func getEntity() -> FeatureEntity { repository.getFeatureData() }
}
