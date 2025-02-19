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
import SettingsFeature

@main
struct BwalletApp: App {
  @State var settingsViewModel = SettingsViewModel(userService: UserService(), title: "Settings")
  
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
                  currencyService: CurrencyService(networkClient: NetworkClient(environment: .preview)),
                  userService: UserService()
                ),
                title: "Portfolio"
              )
            ),
            .settings(title: "Settings", tabSystemIconName: "gearshape.fill", viewModel: $settingsViewModel )
          ]
        )
      )
    }
  }
}
