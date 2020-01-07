import App
import NIO
import Vapor
import VaporGraphQL
import GraphQL

/*
 If Xcode crashes, it can sometimes leave the connection open. Use this command to to force quit
 the local process using port 8080:
 
 .kill $(lsof -t -i:8080)
 */


let environment = try Environment.detect()
let application = try! app(environment)

// Get the response, extract the introspected schema, print it, and write it to ~/downloads.
application.eventLoop.execute {
  do {
    _ = try application.client().get("http://localhost:8080/graphql").map { response in
      let content = "\(response.content)"
      let fileManager = FileManager.default
      let clientSchemaPath = fileManager.urls(for: .downloadsDirectory, in: .userDomainMask).first!
      try content.write(to: clientSchemaPath, atomically: true, encoding: .utf8)
      print(content)
      // close the server
      _ = application.runningServer?.close()
    }
  } catch let error {
    assertionFailure("error writing schema: \(error)")
  }
}

try application.run()
