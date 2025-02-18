//
//  NetworkClient.swift
//  Bwallet
//
//  Created by Jun on 18/2/25.
//

import Foundation
import Combine

public final class NetworkClient {
  private let baseURL: URL?
  private let environment: Environment
  
  public init(environment: Environment) {
    baseURL = URL(string: "https://unimplemented.com")
    self.environment = environment
  }
  
  public func request<T: Decodable>(_ route: Router) -> AnyPublisher<T, Error> {
    switch environment {
    case .live:
      return requestLive(route)
      
    case .preview:
      return requestPreview(route)
    }
  }
  
  private func requestLive<T: Decodable>(_ route: Router) -> AnyPublisher<T, Error> {
    fatalError("Live data request is not supported yet. Out of scope.")
  }
  
  private func requestPreview<T: Decodable>(_ route: Router) -> AnyPublisher<T, Error> {
    return Future<T, Error> { promise in
      guard let fileURL = route.mockBundle.url(forResource: route.mockDataFilename, withExtension: "json") else {
        fatalError("Could not find JSON file \(route.path).json")
      }
      
      guard let data = try? Data(contentsOf: fileURL) else {
        fatalError("Could not read JSON file \(route.path).json")
      }
      
      let decoder = JSONDecoder()
      decoder.keyDecodingStrategy = .convertFromSnakeCase
      try? promise(.success(decoder.decode(T.self, from: data)))
    }
    .eraseToAnyPublisher()
  }
}
