//
//  PortfolioServiceTests.swift
//  Bwallet
//
//  Created by Jun on 18/2/25.
//

@testable import Domain
import Testing
@testable import Service
@testable import API
import Combine

struct PortfolioServiceTests {
  private let service = PreviewPortfolioService(networkClient: NetworkClient(environment: .preview))
  private var cancellables = Set<AnyCancellable>()
  
  @Test mutating func testGetAllAssets_success() async throws {
    var result: Result<[Asset], PortfolioServiceError>?
    
    await confirmation { confirmation in
      service.getAllAssets()
        .sink(
          receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
              result = .failure(error)
              confirmation.confirm()
              
            case .finished:
              break
            }
          },
          receiveValue: { value in
            result = .success(value)
            confirmation.confirm()
          }
        )
        .store(in: &cancellables)
    }
    
    let given = try result?.get()
    
    let expected = try [
      Asset(
        id: ID(rawValue: "1"),
        amount: #require(Decimal(string: "2.1")),
        coin: Crypto(name: "bitcoin", symbol: ID(rawValue: "BTC"))
      ),
      Asset(
        id: ID(rawValue: "2"),
        amount: #require(Decimal(string: "10.8")),
        coin: Crypto(name: "ethereum", symbol: ID(rawValue: "ETH"))
      ),
      Asset(
        id: ID(rawValue: "3"),
        amount: #require(Decimal(string: "12345")),
        coin: Crypto(name: "cronos", symbol: ID(rawValue: "CRO"))
      ),
      Asset(
        id: ID(rawValue: "4"),
        amount: #require(Decimal(string: "98")),
        coin: Crypto(name: "solana", symbol: ID(rawValue: "SOL"))
      ),
      Asset(
        id: ID(rawValue: "5"),
        amount: #require(Decimal(string: "0.9")),
        coin: Crypto(name: "polygon", symbol: ID(rawValue: "MATIC"))
      ),
      Asset(
        id: ID(rawValue: "6"),
        amount: #require(Decimal(string: "100")),
        coin: Crypto(name: "cosmos", symbol: ID(rawValue: "ATOM"))
      ),
      Asset(
        id: ID(rawValue: "7"),
        amount: #require(Decimal(string: "1000000000000000000000000")),
        coin: Crypto(name: "dogecoin", symbol: ID(rawValue: "DOGE"))
      ),
    ]
    
    #expect(given == expected)
  }
}
