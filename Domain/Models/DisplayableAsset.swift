//
//  DisplayableAsset.swift
//  Bwallet
//
//  Created by Jun on 18/2/25.
//

public enum DisplayableAsset: Identifiable, Sendable {
  case content(
    cryptoName: String,
    cryptoSymbol: String,
    balance: String,
    fiatBalance: String,
    id: ID<Crypto>
  )
  
  public var id: String {
    switch self {
    case let .content(_, _, _, _, id):
      return id.rawValue
    }
  }
}
