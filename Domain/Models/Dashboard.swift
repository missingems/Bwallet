//
//  Dashboard.swift
//  Bwallet
//
//  Created by Jun on 19/2/25.
//

public struct Dashboard: Equatable, Sendable {
  public let totalBalance: Decimal
  public let fiatCurrency: Fiat
  public let displayableAssets: [DisplayableAsset]
  
  public init(totalBalance: Decimal, fiatCurrency: Fiat, displayableAssets: [DisplayableAsset]) {
    self.totalBalance = totalBalance
    self.fiatCurrency = fiatCurrency
    self.displayableAssets = displayableAssets
  }
}
