//
//  CurrencyService.swift
//  Bwallet
//
//  Created by Jun on 18/2/25.
//

import Combine
import Domain
import Service

public final class CurrencyService: Service.CurrencyService {
  public let networkClient: any Service.NetworkClient
  
  public init(networkClient: any Service.NetworkClient) {
    self.networkClient = networkClient
  }
  
  public func getCryptoCurrencyToFiatCurrencyRates(
    with fiatCurrency: ID<Fiat>
  ) -> AnyPublisher<[CryptoFiatPair], CurrencyError> {
    guard let router = CurrencyAPI(fiat: fiatCurrency) else {
      return Fail(error: CurrencyError.internalError("Unsupported fiat currency"))
        .eraseToAnyPublisher()
    }
    
    return networkClient.request(router)
      .mapError { error in
        return CurrencyError.internalError(error.localizedDescription)
      }
      .eraseToAnyPublisher()
  }
}
