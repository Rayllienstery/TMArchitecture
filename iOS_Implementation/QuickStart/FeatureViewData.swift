import Foundation

struct FeatureViewData {
  var name: String
  var description: String?

  init(entity: FeatureEntity) {
    self.name = entity.name
    self.description = entity.description
  }
}
