//
//  CurrencyAPI.swift
//  Bwallet
//
//  Created by Jun on 18/2/25.
//

import Service
import Domain

public enum CurrencyAPI: Router {
  case getCryptoToUSDCurrencyRates
  case getCryptoToHKDCurrencyRates
  
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
    case .getCryptoToUSDCurrencyRates:
      return "USDConversionRate"
      
    case .getCryptoToHKDCurrencyRates:
      return "HKDConversionRate"
    }
  }
  
  public var mockBundle: Bundle {
    return Bundle(for: BundleResource.self)
  }
  
  init?(fiat: ID<Fiat>) {
    switch fiat.rawValue.uppercased() {
    case "USD":
      self = .getCryptoToUSDCurrencyRates
      
    case "HKD":
      self = .getCryptoToHKDCurrencyRates
      
    default:
      return nil
    }
  }
}
