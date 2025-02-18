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
    let service = DashboardService(
      portfolioService: PortfolioService(networkClient: NetworkClient(environment: .preview)),
      currencyService: CurrencyService(networkClient: NetworkClient(environment: .preview))
    )
    
    var result: Result<[DisplayableAsset], DashboardServiceError>?
    
    await confirmation { confirmation in
      service.getAllDisplayableAssets(with: ID(rawValue: "HKD")).sink { completion in
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
    let expected: [DisplayableAsset] = [
      .content(
        cryptoName: "bitcoin",
        cryptoSymbol: "BTC",
        balance: "2.1",
        fiatBalance: "99603",
        id: ID(rawValue: "BTC")
      ),
      .content(
        cryptoName: "ethereum",
        cryptoSymbol: "ETH",
        balance: "10.8",
        fiatBalance: "281880",
        id: ID(rawValue: "ETH")
      ),
      .content(
        cryptoName: "cronos",
        cryptoSymbol: "CRO",
        balance: "12345",
        fiatBalance: "8641.5",
        id: ID(rawValue: "CRO")
      ),
      .content(
        cryptoName: "solana",
        cryptoSymbol: "SOL",
        balance: "98",
        fiatBalance: "102214",
        id: ID(rawValue: "SOL")
      ),
      .content(
        cryptoName: "polygon",
        cryptoSymbol: "MATIC",
        balance: "0.9",
        fiatBalance: "3.996",
        id: ID(rawValue: "MATIC")
      ),
      .content(
        cryptoName: "cosmos",
        cryptoSymbol: "ATOM",
        balance: "100",
        fiatBalance: "5414",
        id: ID(rawValue: "ATOM")
      ),
      .content(
        cryptoName: "dogecoin",
        cryptoSymbol: "DOGE",
        balance: "1000000000000000000000000",
        fiatBalance: "950000000000000000000000",
        id: ID(rawValue: "DOGE")
      )
    ]
    
    #expect(given == expected)
  }
  
  @Test mutating func testDashboardService_getDisplayableAssetsForUSD_success() async throws {
    let service = DashboardService(
      portfolioService: PortfolioService(networkClient: NetworkClient(environment: .preview)),
      currencyService: CurrencyService(networkClient: NetworkClient(environment: .preview))
    )
    
    var result: Result<[DisplayableAsset], DashboardServiceError>?
    
    await confirmation { confirmation in
      service.getAllDisplayableAssets(with: ID(rawValue: "USD")).sink { completion in
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
    let expected: [DisplayableAsset] = [
      .content(
        cryptoName: "bitcoin",
        cryptoSymbol: "BTC",
        balance: "2.1",
        fiatBalance: "126000",
        id: ID(rawValue: "BTC")
      ),
      .content(
        cryptoName: "ethereum",
        cryptoSymbol: "ETH",
        balance: "10.8",
        fiatBalance: "36180",
        id: ID(rawValue: "ETH")
      ),
      .content(
        cryptoName: "cronos",
        cryptoSymbol: "CRO",
        balance: "12345",
        fiatBalance: "1111.05",
        id: ID(rawValue: "CRO")
      ),
      .content(
        cryptoName: "solana",
        cryptoSymbol: "SOL",
        balance: "98",
        fiatBalance: "13034",
        id: ID(rawValue: "SOL")
      ),
      .content(
        cryptoName: "polygon",
        cryptoSymbol: "MATIC",
        balance: "0.9",
        fiatBalance: "0.504",
        id: ID(rawValue: "MATIC")
      ),
      .content(
        cryptoName: "cosmos",
        cryptoSymbol: "ATOM",
        balance: "100",
        fiatBalance: "694",
        id: ID(rawValue: "ATOM")
      ),
      .content(
        cryptoName: "dogecoin",
        cryptoSymbol: "DOGE",
        balance: "1000000000000000000000000",
        fiatBalance: "120000000000000000000000",
        id: ID(rawValue: "DOGE")
      )
    ]
    
    #expect(given == expected)
  }
  
  @Test mutating func testDashboardService_getDisplayableAssetsWithUnsupportedCurrency_shouldReceiveError() async throws {
    let service = DashboardService(
      portfolioService: PortfolioService(networkClient: NetworkClient(environment: .preview)),
      currencyService: CurrencyService(networkClient: NetworkClient(environment: .preview))
    )
    
    var result: Result<[DisplayableAsset], DashboardServiceError>?
    
    await confirmation { confirmation in
      service.getAllDisplayableAssets(with: ID(rawValue: "SGD")).sink { completion in
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
    
    #expect(throws: DashboardServiceError.self, performing: {
      let _ = try result?.get()
    })
  }
}
