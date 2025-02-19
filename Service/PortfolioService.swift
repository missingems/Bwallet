//
//  PortfolioService.swift
//  Bwallet
//
//  Created by Jun on 18/2/25.
//

import Combine
import Domain

public enum PortfolioServiceError: Error, Equatable {
  case internalError(String)
}

public protocol PortfolioService {
  var networkClient: NetworkClient { get }
  func getAllAssets() -> AnyPublisher<[Asset], PortfolioServiceError>
  init(networkClient: any Service.NetworkClient)
}
