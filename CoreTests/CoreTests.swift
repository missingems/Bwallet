//
//  CoreTests.swift
//  CoreTests
//
//  Created by Jun on 19/2/25.
//

import Testing
@testable import Core

struct CoreTests {
  @Test func test_formattedWithSeparator() {
    let number = 1_000_000.formattedWithSeparator
    #expect(number == "1,000,000.00")
  }
  
  @Test func test_formattedWithSeparator_decimals() {
    let number = 1_000_000.123.formattedWithSeparator
    #expect(number == "1,000,000.12")
  }
}
