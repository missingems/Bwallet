//
//  CurrencyServiceTests.swift
//  Bwallet
//
//  Created by Jun on 18/2/25.
//

@testable import Domain
import Testing
@testable import Service
@testable import Dependency
import Combine

struct CurrencyServiceTests {
  private let service = CurrencyService(
    networkClient: NetworkClient(environment: .preview)
  )
  
  private var cancellables = Set<AnyCancellable>()
  
  @Test mutating func testGetCryptoCurrencyToHKDCurrencyRates_success() async throws {
    var result: Result<[CryptoFiatPair], CurrencyError>?
    
    await confirmation { confirmation in
      service.getCryptoCurrencyToFiatCurrencyRates(with: ID(rawValue: "HKD"))
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
      CryptoFiatPair(
        coinSymbol: ID(rawValue: "BTC"),
        fiatSymbol: ID(rawValue: "HKD"),
        id: ID(rawValue: "1"),
        rate: #require(Decimal(string: "47430"))
      ),
      CryptoFiatPair(
        coinSymbol: ID(rawValue: "ETH"),
        fiatSymbol: ID(rawValue: "HKD"),
        id: ID(rawValue: "2"),
        rate: #require(Decimal(string: "26100"))
      ),
      CryptoFiatPair(
        coinSymbol: ID(rawValue: "CRO"),
        fiatSymbol: ID(rawValue: "HKD"),
        id: ID(rawValue: "3"),
        rate: #require(Decimal(string: "0.7"))
      ),
      CryptoFiatPair(
        coinSymbol: ID(rawValue: "SOL"),
        fiatSymbol: ID(rawValue: "HKD"),
        id: ID(rawValue: "4"),
        rate: #require(Decimal(string: "1043"))
      ),
      CryptoFiatPair(
        coinSymbol: ID(rawValue: "MATIC"),
        fiatSymbol: ID(rawValue: "HKD"),
        id: ID(rawValue: "5"),
        rate: #require(Decimal(string: "4.44"))
      ),
      CryptoFiatPair(
        coinSymbol: ID(rawValue: "ATOM"),
        fiatSymbol: ID(rawValue: "HKD"),
        id: ID(rawValue: "6"),
        rate: #require(Decimal(string: "54.14"))
      ),
      CryptoFiatPair(
        coinSymbol: ID(rawValue: "DOGE"),
        fiatSymbol: ID(rawValue: "HKD"),
        id: ID(rawValue: "7"),
        rate: #require(Decimal(string: "0.95"))
      ),
    ]
    
    #expect(given == expected)
  }
  
  @Test mutating func testGetCryptoCurrencyToSGDCurrencyRates_shouldReceiveUnsupportedCurrency() async throws {
    var result: Result<[CryptoFiatPair], CurrencyError>?
    
    await confirmation { confirmation in
      service.getCryptoCurrencyToFiatCurrencyRates(with: ID(rawValue: "SGD"))
        .sink(
          receiveCompletion: { completion in
            switch completion {
            case let .failure(error):
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
    
    #expect(throws: CurrencyError.internalError("Unsupported fiat currency")) {
      _ = try result?.get()
    }
  }
  
  @Test mutating func testGetCryptoCurrencyToUSDCurrencyRate_success() async throws {
    var result: Result<[CryptoFiatPair], CurrencyError>?
    
    await confirmation { confirmation in
      service.getCryptoCurrencyToFiatCurrencyRates(with: ID(rawValue: "USD"))
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
      ),
    ]
    
    #expect(given == expected)
  }
}
