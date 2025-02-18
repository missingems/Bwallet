//
//  CurrencyAPITests.swift
//  Bwallet
//
//  Created by Jun on 18/2/25.
//

import Testing
@testable import Dependency

struct CurrencyAPITests {
  @Test func testCurrencyAPI_getCryptoToUSDCurrencyRates() {
    let api = CurrencyAPI.getCryptoToUSDCurrencyRates
    
    #expect(api.method == .get)
    #expect(api.path == "/path")
    #expect(api.headers == [:])
    #expect(api.parameters == nil)
    #expect(api.mockDataFilename == "USDConversionRate")
    #expect(api.mockBundle == Bundle(for: BundleResource.self))
  }
  
  @Test func testCurrencyAPI_getCryptoToHKDCurrencyRates() {
    let api = CurrencyAPI.getCryptoToHKDCurrencyRates
    
    #expect(api.method == .get)
    #expect(api.path == "/path")
    #expect(api.headers == [:])
    #expect(api.parameters == nil)
    #expect(api.mockDataFilename == "HKDConversionRate")
    #expect(api.mockBundle == Bundle(for: BundleResource.self))
  }
}
