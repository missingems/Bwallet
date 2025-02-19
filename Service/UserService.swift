//
//  UserService.swift
//  Bwallet
//
//  Created by Jun on 19/2/25.
//

import Domain

public protocol UserService {
  func getAvailableFiats() -> [Fiat]
  func getSelectedFiatCurrency() -> Fiat
  func setSelectedFiatCurrency(_ fiat: Fiat)
}
