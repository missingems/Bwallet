//
//  SettingsViewModelTests.swift
//  SettingsViewModelTests
//
//  Created by Jun on 19/2/25.
//

import XCTest
@testable import SettingsFeature
@testable import Dependency
import Combine

final class SettingsViewModelTests: XCTestCase {
  var cancellables = Set<AnyCancellable>()
  
  override func tearDown() {
    cancellables.removeAll()
    super.tearDown()
  }
  
  func test_default() {
    let viewModel = SettingsViewModel(userService: UserService(), title: "title")
    XCTAssertEqual(viewModel.title, "title")
    XCTAssertEqual(viewModel.chooseCurrencyLabel, "Choose Currency")
  }
  
  func test_onSelectFiat_shouldUpdateUserDefaul() {
    let service = UserService()
    service.setSelectedFiatCurrency(.init(symbol: .init(rawValue: "USD")))
    precondition(service.getSelectedFiatCurrency() == .init(symbol: .init(rawValue: "USD")))
    
    let viewModel = SettingsViewModel(userService: service, title: "title")
    viewModel.selectedFiat = .init(symbol: .init(rawValue: "USD"))
    
    XCTAssertEqual(viewModel.selectedFiat, .init(symbol: .init(rawValue: "USD")))
    XCTAssertEqual(service.getSelectedFiatCurrency(), .init(symbol: .init(rawValue: "USD")))
  }
  
  func test_getFiats() {
    let service = UserService()
    let viewModel = SettingsViewModel(userService: service, title: "title")
    
    XCTAssertEqual(viewModel.fiats, [.init(symbol: .init(rawValue: "USD")), .init(symbol: .init(rawValue: "HKD"))])
  }
}
