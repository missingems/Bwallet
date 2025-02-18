//
//  JSONReaderTests.swift
//  Bwallet
//
//  Created by Jun on 18/2/25.
//

import Testing
@testable import Domain
@testable import API

struct JSONReaderTests {
  @Test func testDecode_succes() throws {
    let response: [CryptoFiatPair] = try JSONReader.load("HKDConversionRate")
    #expect(response.isEmpty == false)
  }
  
  @Test func testDecode_failure() throws {
    let givenJsonFileName = "_unknown_json_file_"
    
    #expect(throws: JSONReader.Error.resourceNotFound(givenJsonFileName)) {
      let _: [String] = try JSONReader.load(givenJsonFileName)
    }
  }
}
