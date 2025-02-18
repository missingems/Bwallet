//
//  CurrencyService.swift
//  Bwallet
//
//  Created by Jun on 18/2/25.
//

import Combine
import Domain
import Service

final class CurrencyService: Service.CurrencyService {
  let networkClient: NetworkClient
  
  init(networkClient: NetworkClient) {
    self.networkClient = networkClient
  }
  
  func getCryptoCurrencyToFiatCurrencyRates(
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
