//
//  DashboardView.swift
//  Bwallet
//
//  Created by Jun on 19/2/25.
//

import SwiftUI

public struct DashboardView: View {
  private var viewModel: DashboardViewModel
  
  public var body: some View {
    NavigationView {
      VStack(spacing: 0) {
        if let result = viewModel.content {
          switch result {
          case let .success(content):
            ScrollView(.vertical) {
              Section {
                VStack(spacing: 5.0) {
                  ForEach(Array(zip(content.rows, content.rows.indices)), id: \.0.id) { value in
                    let row = value.0
                    let index = value.1
                    
                    rowView(at: index, with: row)
                  }
                }
              } header: {
                sectionHeader(with: content)
                  .padding(.vertical, 34.0)
              }
            }
            .safeAreaPadding(.horizontal, nil)
            
          case let .failure(error):
            Text(error.localizedDescription)
          }
        }
      }
      .navigationTitle(viewModel.title)
      .navigationBarTitleDisplayMode(.inline)
      .onAppear {
        viewModel.send(.onAppear)
      }
    }
  }
  
  public init(viewModel: DashboardViewModel) {
    self.viewModel = viewModel
  }
  
  @ViewBuilder private func sectionHeader(with content: DashboardViewModel.Content) -> some View {
    VStack(alignment: .center, spacing: 5.0) {
      Text(content.header.caption).font(.caption).multilineTextAlignment(.center).foregroundStyle(.secondary)
      Text(content.header.title).font(.title).fontDesign(.monospaced).multilineTextAlignment(.center)
    }
  }
  
  @ViewBuilder private func rowView(at index: Int, with row: DashboardViewModel.Content.Row) -> some View {
    HStack(spacing: 0) {
      VStack(alignment: .leading) {
        Text(row.title).font(.body)
        Text(row.subtitle).font(.caption).foregroundStyle(.secondary)
      }
      
      Spacer()
      
      VStack(alignment: .trailing) {
        Text(row.value).font(.caption).fontDesign(.monospaced).multilineTextAlignment(.trailing)
        Text(row.secondaryValue).font(.caption).foregroundStyle(.secondary).multilineTextAlignment(.trailing)
      }
    }
    .padding(EdgeInsets(top: 8.0, leading: 13.0, bottom: 8.0, trailing: 13.0))
    .background {
      index.isMultiple(of: 2) ? Color.primary.opacity(0.05) : Color.clear
    }
    .clipShape(RoundedRectangle(cornerRadius: 8.0))
  }
}
