//
//  RootView.swift
//  Bwallet
//
//  Created by Jun on 19/2/25.
//

import SwiftUI
import Service
import Dependency
import PortfolioFeature
import SettingsFeature

struct RootView: View {
  let viewModel: RootViewModel
  
  var body: some View {
    TabView {
      ForEach(viewModel.tabs) { tab in
        switch tab {
        case let .portfolio(title, tabSystemIconName, viewModel):
          Tab(title, systemImage: tabSystemIconName) {
            DashboardView(viewModel: viewModel)
          }
          
        case let .settings(title, tabSystemIconName, viewModel):
          Tab(title, systemImage: tabSystemIconName) {
            SettingsView(viewModel: viewModel)
          }
        }
      }
    }
  }
}
