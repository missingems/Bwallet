//
//  CurrencyService.swift
//  Bwallet
//
//  Created by Jun on 18/2/25.
//

import Domain
import Combine

public enum CurrencyError: Error, Equatable {
  case internalError(String)
}

public protocol CurrencyService {
  var networkClient: NetworkClient { get }
  
  func getCryptoCurrencyToFiatCurrencyRates(
    with fiatCurrency: ID<Fiat>
  ) -> AnyPublisher<[CryptoFiatPair], CurrencyError>
}
