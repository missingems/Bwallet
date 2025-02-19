//
//  RootViewModel.swift
//  Bwallet
//
//  Created by Jun on 19/2/25.
//

import Service
import PortfolioFeature
import SettingsFeature
import SwiftUI

struct RootViewModel {
  let tabs: [Tab]
}

extension RootViewModel {
  enum Tab: Identifiable {
    case portfolio(
      title: String,
      tabSystemIconName: String,
      viewModel: DashboardViewModel
    )
    
    case settings(title: String, tabSystemIconName: String, viewModel: Binding<SettingsViewModel>)
    
    var id: String {
      switch self {
      case .portfolio:
        return "portfolio"
        
      case .settings:
        return "settings"
      }
    }
  }
}
