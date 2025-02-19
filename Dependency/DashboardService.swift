//
//  DashboardService.swift
//  Bwallet
//
//  Created by Jun on 18/2/25.
//

import Combine
import Domain
import Service

public final class DashboardService: Service.DashboardService {
  public let portfolioService: Service.PortfolioService
  public let currencyService: Service.CurrencyService
  public let userService: Service.UserService
  
  public init(
    portfolioService: Service.PortfolioService,
    currencyService: Service.CurrencyService,
    userService: Service.UserService
  ) {
    self.portfolioService = portfolioService
    self.currencyService = currencyService
    self.userService = userService
  }
  
  public func getAllDisplayableAssets() -> AnyPublisher<Dashboard, DashboardServiceError> {
    let fiat = userService.getSelectedFiatCurrency()
    
    let assetsPublisher = portfolioService.getAllAssets()
      .mapError { DashboardServiceError.internalError($0.localizedDescription) }
    let ratesPublisher = currencyService.getCryptoCurrencyToFiatCurrencyRates(with: fiat.symbol)
      .mapError { DashboardServiceError.internalError($0.localizedDescription) }
    
    return Publishers.CombineLatest(assetsPublisher, ratesPublisher)
      .map { assets, rates in
        let assets: [DisplayableAsset] = assets.compactMap { asset in
          guard let matchingPair = rates.first(where: { rate in
            rate.cryptoSymbol == asset.crypto.symbol
          }) else {
            return nil
          }
          
          return DisplayableAsset.content(
            cryptoName: asset.crypto.name,
            cryptoSymbol: asset.crypto.symbol.rawValue,
            balance: asset.amount,
            fiatBalance: asset.amount * matchingPair.rate,
            id: asset.crypto.symbol
          )
        }
        
        let totalBalance = assets.map { $0.fiatBalance }.reduce(0, +)
        
        return Dashboard(totalBalance: totalBalance, fiatCurrency: fiat, displayableAssets: assets)
      }
      .eraseToAnyPublisher()
  }
}
