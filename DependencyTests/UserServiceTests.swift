//
//  UserServiceTests.swift
//  Bwallet
//
//  Created by Jun on 19/2/25.
//

@testable import Domain
import Testing
@testable import Dependency

struct UserServiceTests {
  @Test func test_default_getSelectedFiatCurrency() {
    let service = Dependency.UserService()
    service.reset()
    
    #expect(service.getSelectedFiatCurrency() == .init(symbol: .init(rawValue: "USD")))
  }
  
  @Test func test_init_defaultCurrency() {
    let service = Dependency.UserService()
    service.reset()
    
    let service2 = Dependency.UserService()
    #expect(service2.getSelectedFiatCurrency() == .init(symbol: .init(rawValue: "USD")))
  }
  
  @Test func test_setSelectedFiatCurrency() {
    let service = Dependency.UserService()
    service.reset()
    
    service.setSelectedFiatCurrency(.init(symbol: .init(rawValue: "HKD")))
    #expect(service.getSelectedFiatCurrency() == .init(symbol: .init(rawValue: "HKD")))
  }
  
  @Test func test_getFiatCurrencyList() {
    let service = Dependency.UserService()
    #expect(service.getAvailableFiats() == [.init(symbol: .init(rawValue: "USD")), .init(symbol: .init(rawValue: "HKD"))])
  }
}
