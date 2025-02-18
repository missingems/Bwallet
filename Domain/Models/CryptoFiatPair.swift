//
//  CryptoFiatPair.swift
//  Bwallet
//
//  Created by Jun on 18/2/25.
//

public struct CryptoFiatPair: Decodable, Identifiable, Equatable, Sendable {
  public let coinSymbol: ID<Crypto>
  public let fiatSymbol: ID<Fiat>
  public let id: ID<CryptoFiatPair>
  public let rate: Decimal
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    coinSymbol = try .init(rawValue: container.decode(String.self, forKey: .coinSymbol))
    fiatSymbol = try .init(rawValue: container.decode(String.self, forKey: .fiatSymbol))
    id = try ID(rawValue: String(container.decode(Int.self, forKey: .id)))
    
    let rateString = try container.decode(String.self, forKey: .rate)
    
    guard let decimalRate = Decimal(string: rateString) else {
      throw DecodingError.dataCorruptedError(
        forKey: .rate,
        in: container,
        debugDescription: "Invalid decimal value: \(rateString)"
      )
    }
    
    rate = decimalRate
  }
  
  public init(
    coinSymbol: ID<Crypto>,
    fiatSymbol: ID<Fiat>,
    id: ID<CryptoFiatPair>,
    rate: Decimal
  ) {
    self.coinSymbol = coinSymbol
    self.fiatSymbol = fiatSymbol
    self.id = id
    self.rate = rate
  }
}

extension CryptoFiatPair {
  enum CodingKeys: String, CodingKey {
    case coinSymbol = "symbol"
    case fiatSymbol
    case id
    case rate = "fiatRate"
  }
}
