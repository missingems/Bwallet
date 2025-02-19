//
//  DashboardServiceTests.swift
//  Bwallet
//
//  Created by Jun on 18/2/25.
//

import Testing
import Combine
@testable import Domain
@testable import Service
@testable import Dependency

struct DashboardServiceTests {
  var cancellables: Set<AnyCancellable> = []
  
  @Test mutating func testDashboardService_getDisplayableAssetsForHKD_success() async throws {
    let userService = UserService()
    userService.setSelectedFiatCurrency(.init(symbol: .init(rawValue: "HKD")))
    
    let service = DashboardService(
      portfolioService: PortfolioService(networkClient: NetworkClient(environment: .preview)),
      currencyService: CurrencyService(networkClient: NetworkClient(environment: .preview)),
      userService: userService
    )
    
    var result: Result<Dashboard, DashboardServiceError>?
    
    await confirmation { confirmation in
      service.getAllDisplayableAssets().sink { completion in
        switch completion {
        case let .failure(error):
          result = .failure(error)
          confirmation.confirm()
          
        case .finished:
          break
        }
      } receiveValue: { assets in
        result = .success(assets)
        confirmation.confirm()
      }
      .store(in: &cancellables)
    }
    
    let given = try result?.get()
    let expectedAssets: [DisplayableAsset] = try [
      .content(
        cryptoName: "bitcoin",
        cryptoSymbol: "BTC",
        balance: #require(Decimal(string: "2.1")),
        fiatBalance: #require(Decimal(string: "99603")),
        id: ID(rawValue: "BTC")
      ),
      .content(
        cryptoName: "ethereum",
        cryptoSymbol: "ETH",
        balance: #require(Decimal(string: "10.8")),
        fiatBalance: #require(Decimal(string: "281880")),
        id: ID(rawValue: "ETH")
      ),
      .content(
        cryptoName: "cronos",
        cryptoSymbol: "CRO",
        balance: #require(Decimal(string: "12345")),
        fiatBalance: #require(Decimal(string: "8641.5")),
        id: ID(rawValue: "CRO")
      ),
      .content(
        cryptoName: "solana",
        cryptoSymbol: "SOL",
        balance: #require(Decimal(string: "98")),
        fiatBalance: #require(Decimal(string: "102214")),
        id: ID(rawValue: "SOL")
      ),
      .content(
        cryptoName: "polygon",
        cryptoSymbol: "MATIC",
        balance: #require(Decimal(string: "0.9")),
        fiatBalance: #require(Decimal(string: "3.996")),
        id: ID(rawValue: "MATIC")
      ),
      .content(
        cryptoName: "cosmos",
        cryptoSymbol: "ATOM",
        balance: #require(Decimal(string: "100")),
        fiatBalance: #require(Decimal(string: "5414")),
        id: ID(rawValue: "ATOM")
      ),
      .content(
        cryptoName: "dogecoin",
        cryptoSymbol: "DOGE",
        balance: #require(Decimal(string: "1000000000000000000000000")),
        fiatBalance: #require(Decimal(string: "950000000000000000000000")),
        id: ID(rawValue: "DOGE")
      )
    ]
    
    let expected = try Dashboard(
      totalBalance: #require(Decimal(string: "950000000000000000497756.496")),
      fiatCurrency: Fiat(symbol: ID(rawValue: "HKD")),
      displayableAssets: expectedAssets
    )
    
    #expect(given == expected)
  }
  
  @Test mutating func testDashboardService_getDisplayableAssetsForUSD_success() async throws {
    let userService = UserService()
    userService.setSelectedFiatCurrency(.init(symbol: .init(rawValue: "USD")))
    
    let service = DashboardService(
      portfolioService: PortfolioService(networkClient: NetworkClient(environment: .preview)),
      currencyService: CurrencyService(networkClient: NetworkClient(environment: .preview)),
      userService: userService
    )
    
    var result: Result<Dashboard, DashboardServiceError>?
    
    try await confirmation { confirmation in
      service.getAllDisplayableAssets().sink { completion in
        switch completion {
        case let .failure(error):
          result = .failure(error)
          confirmation.confirm()
        case .finished:
          break
        }
      } receiveValue: { assets in
        result = .success(assets)
        confirmation.confirm()
      }
      .store(in: &cancellables)
      
      let given = try result?.get()
      
      let expectedAssets: [DisplayableAsset] = try [
        .content(
          cryptoName: "bitcoin",
          cryptoSymbol: "BTC",
          balance: #require(Decimal(string: "2.1")),
          fiatBalance: #require(Decimal(string: "126000")),
          id: ID(rawValue: "BTC")
        ),
        .content(
          cryptoName: "ethereum",
          cryptoSymbol: "ETH",
          balance: #require(Decimal(string: "10.8")),
          fiatBalance: #require(Decimal(string: "36180")),
          id: ID(rawValue: "ETH")
        ),
        .content(
          cryptoName: "cronos",
          cryptoSymbol: "CRO",
          balance: #require(Decimal(string: "12345")),
          fiatBalance: #require(Decimal(string: "1111.05")),
          id: ID(rawValue: "CRO")
        ),
        .content(
          cryptoName: "solana",
          cryptoSymbol: "SOL",
          balance: #require(Decimal(string: "98")),
          fiatBalance: #require(Decimal(string: "13034")),
          id: ID(rawValue: "SOL")
        ),
        .content(
          cryptoName: "polygon",
          cryptoSymbol: "MATIC",
          balance: #require(Decimal(string: "0.9")),
          fiatBalance: #require(Decimal(string: "0.504")),
          id: ID(rawValue: "MATIC")
        ),
        .content(
          cryptoName: "cosmos",
          cryptoSymbol: "ATOM",
          balance: #require(Decimal(string: "100")),
          fiatBalance: #require(Decimal(string: "694")),
          id: ID(rawValue: "ATOM")
        ),
        .content(
          cryptoName: "dogecoin",
          cryptoSymbol: "DOGE",
          balance: #require(Decimal(string: "1000000000000000000000000")),
          fiatBalance: #require(Decimal(string: "120000000000000000000000")),
          id: ID(rawValue: "DOGE")
        )
      ]
      
      let expected = try Dashboard(
        totalBalance: #require(Decimal(string: "120000000000000000177019.554")),
        fiatCurrency: Fiat(symbol: ID(rawValue: "USD")),
        displayableAssets: expectedAssets
      )
      
      #expect(given == expected)
    }
  }
}
