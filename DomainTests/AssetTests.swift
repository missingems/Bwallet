//
//  AssetTests.swift
//  Bwallet
//
//  Created by Jun on 18/2/25.
//

import Testing
@testable import Domain

struct AssetTests {
  @Test func testDecodingSuccess() throws {
    let jsonData = try #require(
        """
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
        """.data(using: .utf8)
    )
    
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    let givenAssets = try decoder.decode([Asset].self, from: jsonData)
    
    let expectedAssets = [
      Asset(id: ID(rawValue: "1"), amount: 2.1, coin: Crypto(name: "bitcoin", symbol: ID(rawValue: "BTC"))),
      Asset(id: ID(rawValue: "2"), amount: 10.8, coin: Crypto(name: "ethereum", symbol: ID(rawValue: "ETH"))),
      Asset(id: ID(rawValue: "3"), amount: 12345, coin: Crypto(name: "cronos", symbol: ID(rawValue: "CRO"))),
      Asset(id: ID(rawValue: "4"), amount: 98, coin: Crypto(name: "solana", symbol: ID(rawValue: "SOL"))),
      Asset(id: ID(rawValue: "5"), amount: 0.9, coin: Crypto(name: "polygon", symbol: ID(rawValue: "MATIC"))),
      Asset(id: ID(rawValue: "6"), amount: 100, coin: Crypto(name: "cosmos", symbol: ID(rawValue: "ATOM"))),
      Asset(
        id: ID(rawValue: "7"),
        amount: try #require(
          Decimal(string: "1000000000000000000000000")
        ),
        coin: Crypto(
          name: "dogecoin",
          symbol: ID(rawValue: "DOGE")
        )
      ),
    ]
    
    #expect(givenAssets == expectedAssets)
  }
  
  @Test func testDecodingFailure() throws {
    let malformedJsonData = try #require(
        """
        [
            {
                "name":1
                "symbol":2
                "id":"1",
                "amount": "2.1"
            }
        ]
        """.data(using: .utf8)
    )
    
    #expect(throws: DecodingError.self) {
      let decoder = JSONDecoder()
      decoder.keyDecodingStrategy = .convertFromSnakeCase
      _ = try decoder.decode([Asset].self, from: malformedJsonData)
    }
  }
}
