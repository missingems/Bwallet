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
  @Test
  func testDecodingCoinFiatPair() {
    let jsonData = """
        [
            {
                "fiat_rate":"47430",
                "fiat_symbol":"HKD",
                "id":1,
                "symbol":"BTC"
            },
            {
                "fiat_rate":"26100",
                "fiat_symbol":"HKD",
                "symbol":"ETH",
                "id":2
            },
            {
                "fiat_rate":"0.7",
                "fiat_symbol":"HKD",
                "symbol":"CRO",
                "id":3
            },
            {
                "fiat_rate":"1043",
                "fiat_symbol":"HKD",
                "symbol":"SOL",
                "id":4
            },
            {
                "fiat_rate":"4.44",
                "fiat_symbol":"HKD",
                "symbol":"MATIC",
                "id":5
            },
            {
                "fiat_rate":"54.14",
                "fiat_symbol":"HKD",
                "symbol":"ATOM",
                "id":6
            },
            {
                "fiat_rate":"0.95",
                "fiat_symbol":"HKD",
                "symbol":"DOGE",
                "id":7
            }
        ]
        """.data(using: .utf8)!
    
    do {
      let decoder = JSONDecoder()
      decoder.keyDecodingStrategy = .convertFromSnakeCase
      let decodedPairs = try decoder.decode([CoinFiatPair].self, from: jsonData)
      print(decodedPairs)
    } catch {
      print(error)
    }
  }
  
  
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
