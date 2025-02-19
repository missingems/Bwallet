//
//  DashboardViewModel.swift
//  Bwallet
//
//  Created by Jun on 19/2/25.
//

import Combine
import Domain
import Service
import Core

@Observable public final class DashboardViewModel {
  let title: String
  var content: Result<Content, Error>?
  
  private var cancellables = Set<AnyCancellable>()
  private let dashboardService: Service.DashboardService
  
  public init(dashboardService: any Service.DashboardService) {
    self.title = "Portfolio"
    self.dashboardService = dashboardService
  }
  
  func send(_ action: DashboardViewModel.Action) {
    switch action {
    case .onAppear:
      getAllDisplayableAssets()
    }
  }
  
  private func getAllDisplayableAssets() {
    dashboardService.getAllDisplayableAssets(with: Fiat(symbol: ID(rawValue: "HKD")))
      .receive(on: DispatchQueue.main)
      .sink { [weak self] completion in
        switch completion {
        case let .failure(error):
          self?.content = .failure(error)
          
        case .finished:
          break
        }
      } receiveValue: { [weak self] dashboard in
        self?.content = .success(
          DashboardViewModel.Content(
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
