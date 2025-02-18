//
//  DashboardService.swift
//  Bwallet
//
//  Created by Jun on 19/2/25.
//

import Combine
import Domain

public enum DashboardServiceError: Error, Equatable {
  case internalError(String)
}

public protocol DashboardService {
  var currencyService: CurrencyService { get }
  var portfolioService: PortfolioService { get }
  func getAllDisplayableAssets(with fiat: ID<Fiat>) -> AnyPublisher<[Domain.DisplayableAsset], DashboardServiceError>
}
