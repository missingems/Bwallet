//
//  PortfolioService.swift
//  Bwallet
//
//  Created by Jun on 18/2/25.
//

import Domain

public enum PortfolioServiceError: Error {
  case networkError
  case dataError
}

public protocol PortfolioService {
  func getAllAssets(_ onComplete: @escaping (Result<[DisplayableAsset], PortfolioServiceError>) -> Void)
}
