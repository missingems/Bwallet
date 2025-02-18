//
//  NetworkClient.swift
//  Bwallet
//
//  Created by Jun on 19/2/25.
//

import Foundation
import Combine

public protocol NetworkClient {
  var environment: Environment { get }
  var baseURL: URL? { get }
  init(environment: Environment)
  func request<T: Decodable>(_ route: Router) -> AnyPublisher<T, Error>
}
