//
//  JSONReader.swift
//  Bwallet
//
//  Created by Jun on 18/2/25.
//

import Foundation

final class JSONReader {
  enum Error: Swift.Error, Equatable {
    case resourceNotFound(String)
  }
  
  static func load<Model: Decodable>(_ filename: String) throws -> Model {
    guard let url = Bundle(for: JSONReader.self).url(forResource: filename, withExtension: "json") else {
      throw Error.resourceNotFound(filename)
    }
    
    let data = try Data(contentsOf: url)
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    
    return try decoder.decode(Model.self, from: data)
  }
}
