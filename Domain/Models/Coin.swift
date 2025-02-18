//
//  Coin.swift
//  Bwallet
//
//  Created by Jun on 18/2/25.
//

public struct Coin: Equatable {
  public let name: String
  public let symbol: ID<Coin>
  
  public init(
    name: String,
    symbol: ID<Coin>
  ) {
    self.name = name
    self.symbol = symbol
  }
}
