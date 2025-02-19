//
//  SettingsView.swift
//  Bwallet
//
//  Created by Jun on 19/2/25.
//

import SwiftUI
import Combine

public struct SettingsView: View {
  @Binding var viewModel: SettingsViewModel
  
  public var body: some View {
    NavigationStack {
      Form {
        Picker(selection: $viewModel.selectedFiat) {
          ForEach(viewModel.fiats, id: \.symbol.rawValue) { fiat in
            Text(fiat.symbol.rawValue).tag(fiat)
          }
        } label: {
          Text(viewModel.chooseCurrencyLabel)
        }
      }
      .navigationTitle(viewModel.title)
    }
  }
  
  public init(viewModel: Binding<SettingsViewModel>) {
    self._viewModel = viewModel
  }
}
