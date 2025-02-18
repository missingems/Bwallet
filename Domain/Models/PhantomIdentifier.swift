//
//  PhantomIdentifier.swift
//  Bwallet
//
//  Created by Jun on 18/2/25.
//

public struct ID<PhantomType>: Hashable, Decodable {
  public let id: String
}
