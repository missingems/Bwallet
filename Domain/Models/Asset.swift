//
//  Asset.swift
//  Bwallet
//
//  Created by Jun on 18/2/25.
//

public struct Asset: Decodable, Identifiable {
  public let amount: Double
  public let coin: Coin
  public let id: ID<Asset>
  
  private enum CodingKeys: String, CodingKey {
    case amount
    case id
    case name
    case symbol
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    amount = try container.decode(Double.self, forKey: .amount)
    id = ID(id: String(try container.decode(Int.self, forKey: .id)))
    
    let name = try container.decode(String.self, forKey: .name)
    coin = Coin(name: name, symbol: .init(id: String(try container.decode(String.self, forKey: .symbol))))
  }
}
