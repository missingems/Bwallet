//
//  DisplayableAsset.swift
//  Bwallet
//
//  Created by Jun on 18/2/25.
//

public enum DisplayableAsset: Identifiable, Sendable, Equatable {
  case content(
    cryptoName: String,
    cryptoSymbol: String,
    balance: Decimal,
    fiatBalance: Decimal,
    id: ID<Crypto>
  )
  
  public var id: String {
    switch self {
    case let .content(_, _, _, _, id):
      return id.rawValue
    }
  }
  
  public var fiatBalance: Decimal {
    switch self {
    case let .content(_, _, _, fiatBalance, _):
      return fiatBalance
    }
  }
}
