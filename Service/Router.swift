//
//  Router.swift
//  Bwallet
//
//  Created by Jun on 18/2/25.
//

import Foundation

public protocol Router {
  var method: HTTPMethod { get }
  var path: String { get }
  var headers: [String: String]? { get }
  var parameters: [String: Any]? { get }
  var mockDataFilename: String { get }
  var mockBundle: Bundle { get }
}

public enum HTTPMethod: String {
  case get
  case post
  case put
  case delete
}
