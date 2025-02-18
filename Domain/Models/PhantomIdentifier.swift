//
//  PhantomIdentifier.swift
//  Bwallet
//
//  Created by Jun on 18/2/25.
//

public struct ID<PhantomType>: Hashable, Decodable, RawRepresentable, Equatable {
  public var rawValue: String {
    id
  }
  
  public typealias RawValue = String
  
  private let id: String
  
  public init(rawValue id: String) {
    self.id = id
  }
}
