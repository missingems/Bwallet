//
//  Crypto.swift
//  Bwallet
//
//  Created by Jun on 18/2/25.
//

public struct Crypto: Equatable, Sendable {
  public let name: String
  public let symbol: ID<Crypto>
  
  public init(
    name: String,
    symbol: ID<Crypto>
  ) {
    self.name = name
    self.symbol = symbol
  }
}
