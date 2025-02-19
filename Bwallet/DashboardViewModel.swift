//
//  DashboardViewModel.swift
//  Bwallet
//
//  Created by Jun on 19/2/25.
//

import Combine
import Domain
import Service

@Observable final class DashboardViewModel {
  let title: String
  var content: Content?
  var error: Error?
  
  private var cancellables = Set<AnyCancellable>()
  private let dashboardService: Service.DashboardService
  
  init(dashboardService: any Service.DashboardService) {
    self.title = "Portfolio"
    self.dashboardService = dashboardService
  }
  
  func send(_ action: DashboardViewModel.Action) {
    switch action {
    case .onAppear:
      onAppear()
    }
  }
  
  private func onAppear() {
    dashboardService.getAllDisplayableAssets(with: Fiat(symbol: ID(rawValue: "HKD")))
      .receive(on: DispatchQueue.main)
      .sink { [weak self] completion in
        switch completion {
        case .failure(let error):
          self?.error = error
          
        case .finished:
          break
        }
      } receiveValue: { [weak self] dashboard in
        self?.content = DashboardViewModel.Content(
          header: DashboardViewModel.Content.Header(
            title: "$\(dashboard.totalBalance.formattedWithSeparator)",
            caption: "Total Balance (\(dashboard.fiatCurrency.symbol.rawValue))"
          ),
          rows: dashboard.displayableAssets.compactMap { value in
            if case let .content(cryptoName, cryptoSymbol, balance, fiatBalance, id) = value {
              return DashboardViewModel.Content.Row(
                title: cryptoSymbol,
                subtitle: cryptoName.capitalized,
                value: "$\(fiatBalance.formattedWithSeparator)",
                secondaryValue: "\(balance.formattedWithSeparator) \(cryptoSymbol)",
                id: id
              )
            } else {
              return nil
            }
          }
        )
      }
      .store(in: &cancellables)
  }
}

extension DashboardViewModel {
  enum Action {
    case onAppear
  }
}

extension DashboardViewModel {
  struct Content {
    struct Header {
      let title: String
      let caption: String
    }
    
    struct Row {
      let title: String
      let subtitle: String
      let value: String
      let secondaryValue: String
      let id: ID<Crypto>
    }
    
    let header: Header
    let rows: [Row]
  }
}
