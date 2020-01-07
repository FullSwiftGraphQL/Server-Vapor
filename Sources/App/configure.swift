import Vapor
import VaporGraphQL
import GraphQL

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
  
  // Register GraphQL
  let httpGraphQL = HTTPGraphQL { req in
    // This gets called on every request.
    return (
      schema: starWarsSchema.schema,
      rootValue: [:],
      context: ()
    )
  }
  services.register(httpGraphQL, as: GraphQLService.self)
  
  // Register routes to the router
  let router = EngineRouter.default()
  let graphQLRouteCollection = GraphQLRouteCollection(enableGraphiQL: true)
  try graphQLRouteCollection.boot(router: router)
  try routes(router)
  services.register(router, as: Router.self)

  
  // Register middleware
  var middlewares = MiddlewareConfig() // Create _empty_ middleware config
  // middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
  middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
  services.register(middlewares)
  
}
