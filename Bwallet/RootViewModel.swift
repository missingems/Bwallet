//
//  RootViewModel.swift
//  Bwallet
//
//  Created by Jun on 19/2/25.
//

import Service
import PortfolioFeature

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
    
    var id: String {
      switch self {
      case .portfolio:
        return "portfolio"
      }
    }
  }
}
