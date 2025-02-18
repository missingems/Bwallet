//
//  Asset.swift
//  Bwallet
//
//  Created by Jun on 18/2/25.
//

public struct Asset: Decodable, Identifiable, Equatable, Sendable {
  public let amount: Decimal
  public let crypto: Crypto
  public let id: ID<Asset>
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    amount = try container.decode(Decimal.self, forKey: .amount)
    id = try ID(rawValue: String(container.decode(Int.self, forKey: .id)))
    
    crypto = try Crypto(
      name: container.decode(String.self, forKey: .name),
      symbol: .init(rawValue: String(container.decode(String.self, forKey: .symbol)))
    )
  }
  
  public init(
    id: ID<Asset>,
    amount: Decimal,
    coin: Crypto
  ) {
    self.id = id
    self.amount = amount
    self.crypto = coin
  }
}

private extension Asset {
  enum CodingKeys: String, CodingKey {
    case amount
    case id
    case name
    case symbol
  }
}
