//
//  SettingsViewModel.swift
//  Bwallet
//
//  Created by Jun on 19/2/25.
//

import Domain
import Service

@Observable public final class SettingsViewModel {
  let title: String
  let chooseCurrencyLabel: String
  let userService: any UserService
  var fiats: [Fiat]
  
  public var selectedFiat: Fiat {
    didSet {
      userService.setSelectedFiatCurrency(selectedFiat)
    }
  }
  
  public init(userService: any UserService, title: String) {
    self.title = title
    self.userService = userService
    selectedFiat = userService.getSelectedFiatCurrency()
    fiats = userService.getAvailableFiats()
    chooseCurrencyLabel = "Choose Currency"
  }
}
