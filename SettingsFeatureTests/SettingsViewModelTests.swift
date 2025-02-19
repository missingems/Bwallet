////
////  SettingsViewModelTests.swift
////  SettingsViewModelTests
////
////  Created by Jun on 19/2/25.
////
//
//import XCTest
//@testable import SettingsFeature
//@testable import Dependency
//import Combine
//
//final class SettingsViewModelTests: XCTestCase {
//  var cancellables = Set<AnyCancellable>()
//  
//  func test_default() {
//    let service = DashboardService(
//      portfolioService: PortfolioService(networkClient: NetworkClient(environment: .preview)),
//      currencyService: CurrencyService(networkClient: NetworkClient(environment: .preview))
//    )
//    
//    let viewModel = DashboardViewModel(dashboardService: service, title: "Portfolio")
//    XCTAssertEqual(viewModel.state, .loading)
//    XCTAssertEqual(viewModel.title, "Portfolio")
//  }
//}
