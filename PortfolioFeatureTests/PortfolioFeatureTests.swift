//
//  PortfolioFeatureTests.swift
//  PortfolioFeatureTests
//
//  Created by Jun on 19/2/25.
//

import XCTest
@testable import PortfolioFeature
@testable import Dependency
import Combine

final class PortfolioFeatureTests: XCTestCase {
  var cancellables = Set<AnyCancellable>()
  
  override func tearDown() {
    cancellables.removeAll()
    super.tearDown()
  }
  
  func test_default() {
    let service = DashboardService(
      portfolioService: PortfolioService(networkClient: NetworkClient(environment: .preview)),
      currencyService: CurrencyService(networkClient: NetworkClient(environment: .preview)),
      userService: UserService()
    )
    
    let viewModel = DashboardViewModel(dashboardService: service, title: "Portfolio")
    XCTAssertEqual(viewModel.state, .loading)
    XCTAssertEqual(viewModel.title, "Portfolio")
  }
  
  func test_onAppear_withHKDSelected_getAllDisplayableAssets() async throws {
    let userService = UserService()
    userService.setSelectedFiatCurrency(.init(symbol: .init(rawValue: "HKD")))
    
    let service = DashboardService(
      portfolioService: PortfolioService(networkClient: NetworkClient(environment: .preview)),
      currencyService: CurrencyService(networkClient: NetworkClient(environment: .preview)),
      userService: userService
    )
    
    let viewModel = DashboardViewModel(dashboardService: service, title: "Portfolio")
    precondition(viewModel.state == .loading)
    
    let expectation = XCTestExpectation(description: #function)
    expectation.expectedFulfillmentCount = 1
    
    withObservationTracking {
      _ = viewModel.state
    } onChange: {
      expectation.fulfill()
    }
    
    viewModel.send(.onAppear)
    
    await fulfillment(of: [expectation])
    
    let givenState = viewModel.state
    let expectedState = DashboardViewModel.State.data(
      .init(
        header: .init(
          title: "$950,000,000,000,000,000,497,756.50",
          caption: "Total Balance (HKD)"
        ),
        rows: [
          .init(title: "BTC", subtitle: "Bitcoin", value: "$99,603.00", secondaryValue: "2.10 BTC", id: .init(rawValue: "BTC")),
          .init(title: "ETH", subtitle: "Ethereum", value: "$281,880.00", secondaryValue: "10.80 ETH", id: .init(rawValue: "ETH")),
          .init(title: "CRO", subtitle: "Cronos", value: "$8,641.50", secondaryValue: "12,345.00 CRO", id: .init(rawValue: "CRO")),
          .init(title: "SOL", subtitle: "Solana", value: "$102,214.00", secondaryValue: "98.00 SOL", id: .init(rawValue: "SOL")),
          .init(title: "MATIC", subtitle: "Polygon", value: "$4.00", secondaryValue: "0.90 MATIC", id: .init(rawValue: "MATIC")),
          .init(title: "ATOM", subtitle: "Cosmos", value: "$5,414.00", secondaryValue: "100.00 ATOM", id: .init(rawValue: "ATOM")),
          .init(title: "DOGE", subtitle: "Dogecoin", value: "$950,000,000,000,000,000,000,000.00", secondaryValue: "1,000,000,000,000,000,000,000,000.00 DOGE", id: .init(rawValue: "DOGE")),
        ]
      )
    )
    
    XCTAssertEqual(givenState, expectedState)
  }
}
