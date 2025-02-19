//
//  BwalletApp.swift
//  Bwallet
//
//  Created by Jun on 18/2/25.
//

import SwiftUI
import Service
import Dependency
import PortfolioFeature

@main
struct BwalletApp: App {
  var body: some Scene {
    WindowGroup {
      RootView(
        viewModel: RootViewModel(
          tabs: [
            .portfolio(
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
          ]
        )
      )
    }
  }
}
