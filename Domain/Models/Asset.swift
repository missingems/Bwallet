//
//  Asset.swift
//  Bwallet
//
//  Created by Jun on 18/2/25.
//

public struct Asset: Decodable, Identifiable, Equatable {
  public let amount: Decimal
  public let coin: Coin
  public let id: ID<Asset>
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    amount = try container.decode(Decimal.self, forKey: .amount)
    id = ID(rawValue: String(try container.decode(Int.self, forKey: .id)))
    
    let name = try container.decode(String.self, forKey: .name)
    coin = Coin(name: name, symbol: .init(rawValue: String(try container.decode(String.self, forKey: .symbol))))
  }
  
  public init(
    id: ID<Asset>,
    amount: Decimal,
    coin: Coin
  ) {
    self.id = id
    self.amount = amount
    self.coin = coin
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
