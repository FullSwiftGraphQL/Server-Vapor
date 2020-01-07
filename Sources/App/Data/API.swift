import Graphiti

// secretBackstory is a property that doesn't exist in our original entity,
// but we'd like to expose it to Graphiti.
extension Character {
  var secretBackstory: String? {
    return nil
  }
}

// In aligment with our guidelines we have to define the keys for protocols
// in a global enum, because we can't adopt FieldKeyProvider in protocol
// extensions. The role of FieldKeyProvider will become clearer in the
// next extension.
enum CharacterFieldKeys : String {
  case id
  case name
  case friends
  case appearsIn
  case secretBackstory
}

// FieldKeyProvider is a protocol that allows us to define the keys which
// will be used to map properties and functions to GraphQL fields.
extension Planet : FieldKeyProvider {
  typealias FieldKey = FieldKeys
  
  enum FieldKeys : String {
    case id
    case name
    case diameter
    case rotationPeriod
    case orbitalPeriod
    case residents
  }
}

extension Human : FieldKeyProvider {
  typealias FieldKey = FieldKeys
  
  enum FieldKeys : String {
    case id
    case name
    case appearsIn
    case homePlanet
    case friends
    case secretBackstory
  }
  
  // This is the basic layout of a resolve function.
  // The first parameter is the context and the second parameter are
  // the arguments. In this case we have no arguments so we use the
  // provided type `NoArguments`. In a later example you will see how
  // to use parameters.
  func getFriends(store: StarWarsStore, arguments: NoArguments) -> [Character] {
    store.getFriends(of: self)
  }
  
  // Resolve functions can throw.
  func getSecretBackstory(store: StarWarsStore, arguments: NoArguments) throws -> String? {
    try store.getSecretBackStory()
  }
}

extension Droid : FieldKeyProvider {
  typealias FieldKey = FieldKeys
  
  enum FieldKeys : String {
    case id
    case name
    case appearsIn
    case primaryFunction
    case friends
    case secretBackstory
  }
  
  func getFriends(store: StarWarsStore, arguments: NoArguments) -> [Character] {
    store.getFriends(of: self)
  }
  
  func getSecretBackstory(store: StarWarsStore, arguments: NoArguments) throws -> String? {
    try store.getSecretBackStory()
  }
}

struct StarWarsAPI : FieldKeyProvider {
  typealias FieldKey = FieldKeys
  
  enum FieldKeys : String {
    case id
    case episode
    case hero
    case human
    case droid
    case search
    case query
  }
  
  // Here we are defining the arguments for the getHero function.
  // Arguments need to adopt the Codable protocol.
  struct HeroArguments : Codable {
    let episode: Episode?
  }
  
  // Here we're simplin defining `HeroArguments` as the arguments for the
  // getHero function.
  func getHero(store: StarWarsStore, arguments: HeroArguments) -> Character {
    store.getHero(of: arguments.episode)
  }
  
  struct HumanArguments : Codable {
    let id: String
  }
  
  func getHuman(store: StarWarsStore, arguments: HumanArguments) -> Human? {
    store.getHuman(id: arguments.id)
  }
  
  struct DroidArguments : Codable {
    let id: String
  }
  
  func getDroid(store: StarWarsStore, arguments: DroidArguments) -> Droid? {
    store.getDroid(id: arguments.id)
  }
  
  struct SearchArguments : Codable {
    let query: String
  }
  
  func search(store: StarWarsStore, arguments: SearchArguments) -> [SearchResult] {
    store.search(query: arguments.query)
  }
}
