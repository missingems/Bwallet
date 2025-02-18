//
//  CoinFiatPairTests.swift
//  Bwallet
//
//  Created by Jun on 18/2/25.
//

import Testing
@testable import Domain

struct CoinFiatPairTests {
  @Test func testDecoding_success() throws {
    let jsonData = try #require(
    """
    [
        {
            "fiat_rate": "60000",
            "fiat_symbol": "USD",
            "id": 1,
            "symbol": "BTC"
        },
        {
            "fiat_rate": "3350",
            "fiat_symbol": "USD",
            "symbol": "ETH",
            "id": 2
        },
        {
            "fiat_rate": "0.09",
            "fiat_symbol": "USD",
            "symbol": "CRO",
            "id": 3
        },
        {
            "fiat_rate": "133",
            "fiat_symbol": "USD",
            "symbol": "SOL",
            "id": 4
        },
        {
            "fiat_rate": "0.56",
            "fiat_symbol": "USD",
            "symbol": "MATIC",
            "id": 5
        },
        {
            "fiat_rate": "6.94",
            "fiat_symbol": "USD",
            "symbol": "ATOM",
            "id": 6
        },
        {
            "fiat_rate": "0.12",
            "fiat_symbol": "USD",
            "symbol": "DOGE",
            "id": 7
        }
    ]
    """.data(using: .utf8)
    )
    
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    let givenCoinFiatPairs = try decoder.decode([CryptoFiatPair].self, from: jsonData)
    
    let expectedCoinFiatPairs = try [
      CryptoFiatPair(
        coinSymbol: ID(rawValue: "BTC"),
        fiatSymbol: ID(rawValue: "USD"),
        id: ID(rawValue: "1"),
        rate: #require(Decimal(string: "60000"))
      ),
      CryptoFiatPair(
        coinSymbol: ID(rawValue: "ETH"),
        fiatSymbol: ID(rawValue: "USD"),
        id: ID(rawValue: "2"),
        rate: #require(Decimal(string: "3350"))
      ),
      CryptoFiatPair(
        coinSymbol: ID(rawValue: "CRO"),
        fiatSymbol: ID(rawValue: "USD"),
        id: ID(rawValue: "3"),
        rate: #require(Decimal(string: "0.09"))
      ),
      CryptoFiatPair(
        coinSymbol: ID(rawValue: "SOL"),
        fiatSymbol: ID(rawValue: "USD"),
        id: ID(rawValue: "4"),
        rate: #require(Decimal(string: "133"))
      ),
      CryptoFiatPair(
        coinSymbol: ID(rawValue: "MATIC"),
        fiatSymbol: ID(rawValue: "USD"),
        id: ID(rawValue: "5"),
        rate: #require(Decimal(string: "0.56"))
      ),
      CryptoFiatPair(
        coinSymbol: ID(rawValue: "ATOM"),
        fiatSymbol: ID(rawValue: "USD"),
        id: ID(rawValue: "6"),
        rate: #require(Decimal(string: "6.94"))
      ),
      CryptoFiatPair(
        coinSymbol: ID(rawValue: "DOGE"),
        fiatSymbol: ID(rawValue: "USD"),
        id: ID(rawValue: "7"),
        rate: #require(Decimal(string: "0.12"))
      )
    ]
    
    #expect(givenCoinFiatPairs == expectedCoinFiatPairs)
  }
  
  @Test func testDecodingWithMalformedData_failure() throws {
    let malformedJsonData = try #require(
        """
        [
            {
                "fiat_rate": 60000,
                "fiat_symbol": 1,
                "id": "1",
                "symbol": 1
            }
        ]
        """.data(using: .utf8)
    )
    
    #expect(throws: DecodingError.self) {
      let decoder = JSONDecoder()
      decoder.keyDecodingStrategy = .convertFromSnakeCase
      _ = try decoder.decode([CryptoFiatPair].self, from: malformedJsonData)
    }
  }
}
