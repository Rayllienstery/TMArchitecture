// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "TMArchitecture",
  products: [
    .library(
      name: "TMArchitecture",
      targets: ["TMArchitecture"])
  ],
  dependencies: [
    .package(url: "https://github.com/Rayllienstery/TMNavigation.git", from: "1.0.0")
  ],
  targets: [
    .target(
      name: "TMArchitecture",
      dependencies: [
        .product(name: "TMNavigation", package: "TMNavigation")
      ])
  ]
)
