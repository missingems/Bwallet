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
  init(
    portfolioService: Service.PortfolioService,
    currencyService: Service.CurrencyService
  )
  func getAllDisplayableAssets(with fiat: Fiat) -> AnyPublisher<Dashboard, DashboardServiceError>
}
