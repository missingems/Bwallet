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
      TabView {
        DashboardView(
          viewModel: DashboardViewModel(
            dashboardService: Dependency.DashboardService(
              portfolioService: Dependency.PortfolioService(networkClient: Dependency.NetworkClient(environment: .preview)),
              currencyService: Dependency.CurrencyService(networkClient: Dependency.NetworkClient(environment: .preview))
            )
          )
        )
      }
    }
  }
}
