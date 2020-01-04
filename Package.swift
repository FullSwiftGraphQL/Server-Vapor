// swift-tools-version:5.1
import PackageDescription

let package = Package(
  name: "VaporApp",
  products: [
    .library(name: "VaporApp", targets: ["App"]),
  ],
  dependencies: [
    // 💧 A server-side Swift web framework.
    .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
    
    // GraphQL
    .package(url: "https://github.com/GraphQLSwift/GraphQL.git", .upToNextMajor(from: "0.12.0")),
    .package(url: "https://github.com/GraphQLSwift/Graphiti.git", .upToNextMajor(from: "0.11.0")),
    // Forked from StevenLambion/GraphQLRouteCollection.git
    .package(url: "https://github.com/noahemmet/GraphQLRouteCollection.git", .branch("fullswift")),
  ],
  targets: [
    .target(name: "App", dependencies: ["GraphQL", "Graphiti", "Vapor"]),
    .target(name: "Run", dependencies: ["App"]),
    .testTarget(name: "AppTests", dependencies: ["App"])
  ]
)
