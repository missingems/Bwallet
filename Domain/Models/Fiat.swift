//
//  Fiat.swift
//  Bwallet
//
//  Created by Jun on 18/2/25.
//

public struct Fiat: Equatable, Sendable {
  public let symbol: ID<Fiat>
  
  public init(symbol: ID<Fiat>) {
    self.symbol = symbol
  }
}
