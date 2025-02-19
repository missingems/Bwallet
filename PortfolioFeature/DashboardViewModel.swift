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
  var state: State
  
  private var cancellables = Set<AnyCancellable>()
  private let dashboardService: Service.DashboardService
  
  public init(dashboardService: any Service.DashboardService, title: String) {
    self.title = title
    self.dashboardService = dashboardService
    self.state = .loading
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
          self?.state = .error(error.localizedDescription)
          
        case .finished:
          break
        }
      } receiveValue: { [weak self] dashboard in
        self?.state = .data(
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
  enum State: Equatable {
    case loading
    case data(Content)
    case error(String)
  }
  
  struct Content: Equatable {
    struct Header: Equatable {
      let title: String
      let caption: String
    }
    
    struct Row: Equatable {
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
