//
//  PortfolioAPI.swift
//  Bwallet
//
//  Created by Jun on 18/2/25.
//

import Service
import Domain

public enum PortfolioAPI: Router {
  case getAllAssets
  
  public var method: HTTPMethod {
    return .get
  }
  
  public var path: String {
    return "/path"
  }
  
  public var headers: [String: String]? {
    return [:]
  }
  
  public var parameters: [String : Any]? {
    return nil
  }
  
  public var mockDataFilename: String {
    switch self {
    case .getAllAssets:
      return "Assets"
    }
  }
  
  public var mockBundle: Bundle {
    return Bundle(for: BundleResource.self)
  }
}
