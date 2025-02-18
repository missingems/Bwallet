//
//  CurrencyService.swift
//  Bwallet
//
//  Created by Jun on 18/2/25.
//

import Combine
import Domain
import Service

final class PreviewCurrencyService: Service.CurrencyService {
  enum PreviewableCurrency {
    case hkd
    case usd
    
    init?(_ id: ID<Fiat>) {
      switch id.rawValue.uppercased() {
      case "HKD":
        self = .hkd
        
      case "USD":
        self = .usd
        
      default:
        return nil
      }
    }
  }
  
  func getCryptoCurrencyToFiatCurrencyRates(
    with fiatCurrency: ID<Fiat>
  ) -> AnyPublisher<[CryptoFiatPair], CurrencyError> {
    Future<[CryptoFiatPair], CurrencyError> { promise in
      guard let previewableCurrency = PreviewableCurrency(fiatCurrency) else {
        promise(.failure(.internalError("Unsupported fiat currency")))
        return
      }
      
      switch previewableCurrency {
      case .hkd:
        try? promise(.success(JSONReader.load("HKDConversionRate")))
        
      case .usd:
        try? promise(.success(JSONReader.load("USDConversionRate")))
      }
    }
    .eraseToAnyPublisher()
  }
}
