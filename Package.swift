// swift-tools-version:5.1
import PackageDescription

let package = Package(
  name: "VaporApp",
  products: [
    .library(name: "VaporApp", targets: ["App", "Generate Schema"]),
  ],
  dependencies: [
    // 💧 A server-side Swift web framework.
    .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
    
    // GraphQL
    .package(url: "https://github.com/GraphQLSwift/GraphQL.git", .upToNextMajor(from: "0.12.0")),
    // This fork publicizes the `schema` property. (https://github.com/GraphQLSwift/Graphiti/pull/34)
    .package(url: "https://github.com/noahemmet/Graphiti.git", .branch("patch-3")),
    // Forked from StevenLambion/GraphQLRouteCollection.git
    .package(url: "https://github.com/noahemmet/GraphQLRouteCollection.git", .branch("fullswift")),
  ],
  targets: [
    .target(name: "App", dependencies: ["GraphQL", "Graphiti", "VaporGraphQL", "Vapor"]),
    .target(name: "Run", dependencies: ["App"]),
    .target(name: "Generate Schema", dependencies: ["App", "GraphQL", "Graphiti", "VaporGraphQL", "Vapor"]),
    
    // Tests
    .testTarget(name: "AppTests", dependencies: ["App"])
  ]
)
