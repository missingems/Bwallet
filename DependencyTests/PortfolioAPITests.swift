//
//  PortfolioAPITests.swift
//  Bwallet
//
//  Created by Jun on 18/2/25.
//

import Testing
@testable import Dependency

struct PortfolioAPITests {
  @Test func testPortfolioAPI_getAllAssets() {
    let api = PortfolioAPI.getAllAssets
    
    #expect(api.method == .get)
    #expect(api.path == "/path")
    #expect(api.headers == [:])
    #expect(api.parameters == nil)
    #expect(api.mockDataFilename == "Assets")
    #expect(api.mockBundle == Bundle(for: BundleResource.self))
  }
}
