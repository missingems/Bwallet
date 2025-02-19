//
//  RootViewModelTests.swift
//  Bwallet
//
//  Created by Jun on 19/2/25.
//

import Testing
@testable import Bwallet
@testable import Service
@testable import Dependency
@testable import PortfolioFeature

struct RootViewModelTests {
  @Test func test_portfolioTab_id() {
    let tab = RootViewModel.Tab.portfolio(
      title: "Portfolio",
      tabSystemIconName: "chart.bar.horizontal.page.fill",
      viewModel: DashboardViewModel(
        dashboardService: DashboardService(
          portfolioService: PortfolioService(networkClient: NetworkClient(environment: .preview)),
          currencyService: CurrencyService(networkClient: NetworkClient(environment: .preview))
        ),
        title: "Portfolio"
      )
    )
    
    #expect(tab.id == "portfolio")
  }
}
