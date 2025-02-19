//
//  UserService.swift
//  Bwallet
//
//  Created by Jun on 19/2/25.
//

import Combine
import Domain
import Service

public final class UserService: Service.UserService {
  public init() {
    if UserDefaults.standard.string(forKey: "selectedFiatCurrency") == nil {
      UserDefaults.standard.set(Domain.Fiat(symbol: .init(rawValue: "USD")).symbol.rawValue, forKey: "selectedFiatCurrency")
      UserDefaults.standard.synchronize()
    }
  }
  
  public func getAvailableFiats() -> [Domain.Fiat] {
    return [
      .init(symbol: .init(rawValue: "USD")),
      .init(symbol: .init(rawValue: "HKD"))
    ]
  }
  
  public func getSelectedFiatCurrency() -> Domain.Fiat {
    return UserDefaults.standard.string(forKey: "selectedFiatCurrency").map { value in
      Domain.Fiat(symbol: .init(rawValue: value))
    } ?? Domain.Fiat(symbol: .init(rawValue: "USD"))
  }
  
  public func setSelectedFiatCurrency(_ fiat: Domain.Fiat) {
    UserDefaults.standard.set(fiat.symbol.rawValue, forKey: "selectedFiatCurrency")
    UserDefaults.standard.synchronize()
  }
}
