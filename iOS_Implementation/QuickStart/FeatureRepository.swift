import Foundation

protocol FeatureRepository {
  func getFeatureData() -> FeatureEntity
}

final class FeatureRepositoryImpl: FeatureRepository {
  func getFeatureData() -> FeatureEntity {
    return FeatureEntity(
      name: "Feature Name",
      description: "Feature Description \(Date().description)"
    )
  }
}
