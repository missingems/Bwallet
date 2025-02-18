//
//  CryptoFiatPair.swift
//  Bwallet
//
//  Created by Jun on 18/2/25.
//

public struct CoinFiatPair: Decodable, Identifiable {
  private enum CodingKeys: String, CodingKey {
    case coinSymbol = "symbol"
    case fiatSymbol
    case id
    case rate = "fiatRate"
  }
  
  public let coinSymbol: ID<Coin>
  public let fiatSymbol: ID<Fiat>
  public let id: ID<CoinFiatPair>
  public let rate: String
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    coinSymbol = try .init(rawValue: container.decode(String.self, forKey: .coinSymbol))
    fiatSymbol = try .init(rawValue: container.decode(String.self, forKey: .fiatSymbol))
    id = try ID(rawValue: String(container.decode(Int.self, forKey: .id)))
    rate = try container.decode(String.self, forKey: .rate)
  }
}
