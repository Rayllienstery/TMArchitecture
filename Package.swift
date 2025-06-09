// swift-tools-version:5.9
import PackageDescription

let package = Package(
  name: "TMArchitecture",
  platforms: [
    .iOS(.v17),
    .macOS(.v14),
  ],
  products: [
    .library(
      name: "TMArchitecture",
      targets: ["TMArchitecture"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/Rayllienstery/TMNavigation.git", from: "1.0.0")
  ],
  targets: [
    .target(
      name: "TMArchitecture",
      dependencies: [
        .product(name: "TMNavigation", package: "TMNavigation")
      ],
      path: "iOS Implementation"
    ),
    .testTarget(
      name: "TMArchitectureTests",
      dependencies: ["TMArchitecture"],
      path: "UnitTests"
    ),
  ]
)
