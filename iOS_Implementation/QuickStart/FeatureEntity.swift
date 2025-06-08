import Foundation

final class FeatureEntity: Codable, Identifiable {
  var id: String
  var name: String
  var description: String?

  init(name: String, description: String? = nil) {
    self.id = UUID().uuidString
    self.name = name
    self.description = description
  }
}
