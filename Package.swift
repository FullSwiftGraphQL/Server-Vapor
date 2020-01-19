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
    // Note there is an issue with @functionBuilders and Graphiti: https://github.com/GraphQLSwift/Graphiti/issues/32
    // Forked from https://github.com/GraphQLSwift/GraphQL
    .package(url: "https://github.com/alexsteinerde/GraphQL.git", .branch("master")),
    // Forked from https://github.com/GraphQLSwift/Graphiti
    .package(url: "https://github.com/alexsteinerde/Graphiti.git", .revision("a0c55a9")),
    // Forked from https://github.com/StevenLambion/GraphQLRouteCollection
    .package(url: "https://github.com/noahemmet/GraphQLRouteCollection.git", .branch("example-app")),
  ],
  targets: [
    .target(name: "App", dependencies: ["GraphQL", "Graphiti", "VaporGraphQL", "Vapor"]),
    .target(name: "Run", dependencies: ["App"]),
    .target(name: "Generate Schema", dependencies: ["App", "GraphQL", "Graphiti", "VaporGraphQL", "Vapor"]),
    
    // Tests
    .testTarget(name: "AppTests", dependencies: ["App"])
  ]
)
