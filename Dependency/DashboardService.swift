//
//  DashboardService.swift
//  Bwallet
//
//  Created by Jun on 18/2/25.
//

import Combine
import Domain
import Service

final class DashboardService: Service.DashboardService {
  let portfolioService: Service.PortfolioService
  let currencyService: Service.CurrencyService
  
  internal init(
    portfolioService: Service.PortfolioService,
    currencyService: Service.CurrencyService
  ) {
    self.portfolioService = portfolioService
    self.currencyService = currencyService
  }
  
  func getAllDisplayableAssets(with fiat: ID<Fiat>) -> AnyPublisher<[Domain.DisplayableAsset], DashboardServiceError> {
    let assetsPublisher = portfolioService.getAllAssets()
      .mapError { DashboardServiceError.internalError($0.localizedDescription) }
    let ratesPublisher = currencyService.getCryptoCurrencyToFiatCurrencyRates(with: fiat)
      .mapError { DashboardServiceError.internalError($0.localizedDescription) }
    
    return Publishers.CombineLatest(assetsPublisher, ratesPublisher)
      .map { assets, rates in
        return assets.compactMap { asset in
          guard let matchingPair = rates.first(where: { rate in
            rate.cryptoSymbol == asset.crypto.symbol
          }) else {
            return nil
          }
          
          return DisplayableAsset.content(
            cryptoName: asset.crypto.name,
            cryptoSymbol: asset.crypto.symbol.rawValue,
            balance: "\(asset.amount)",
            fiatBalance: "\(asset.amount * matchingPair.rate)",
            id: asset.crypto.symbol
          )
        }
      }
      .eraseToAnyPublisher()
  }
}
