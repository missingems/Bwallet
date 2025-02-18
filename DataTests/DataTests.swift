//
//  DataTests.swift
//  DataTests
//
//  Created by Jun on 18/2/25.
//

import Testing
@testable import Data
@testable import Domain

struct DataTests {

    @Test func example() async throws {
      let jsonData = """
[
    {
        "name":"bitcoin",
        "symbol":"BTC",
        "id":1,
        "amount": 2.1
    },
    {
        "name":"ethereum",
        "symbol":"ETH",
        "id":2,
        "amount": 10.8
    },
    {
        "name":"cronos",
        "symbol":"CRO",
        "id":3,
        "amount": 12345
    },
    {
        "name":"solana",
        "symbol":"SOL",
        "id":4,
        "amount": 98
    },
    {
        "name":"polygon",
        "symbol":"MATIC",
        "id":5,
        "amount": 0.9
    },
    {
        "name":"cosmos",
        "symbol":"ATOM",
        "id":6,
        "amount": 100
    },
    {
        "name":"dogecoin",
        "symbol":"DOGE",
        "id":7,
        "amount": 1000000000000000000000000
    }
]
""".data(using: .utf8)!
      
      do {
        let assets = try JSONDecoder().decode([Asset].self, from: jsonData)
        print(assets)
      } catch {
        print("Decoding failed:", error)
      }
    }

}
