//
//  Numeric+Extension.swift
//  Bwallet
//
//  Created by Jun on 19/2/25.
//

import Foundation

extension Numeric {
  var formattedWithSeparator: String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = 2
    formatter.maximumFractionDigits = 2
    return formatter.string(for: self) ?? "\(self)"
  }
}
