//
//  PortfolioService.swift
//  Bwallet
//
//  Created by Jun on 18/2/25.
//

import Combine
import Domain
import Service

public final class PortfolioService: Service.PortfolioService {
  public var networkClient: any Service.NetworkClient
  
  public init(networkClient: any Service.NetworkClient) {
    self.networkClient = networkClient
  }
  
  public func getAllAssets() -> AnyPublisher<[Asset], PortfolioServiceError> {
    let router = PortfolioAPI.getAllAssets
    
    return networkClient.request(router)
      .mapError { error in
        return PortfolioServiceError.internalError(error.localizedDescription)
      }
      .eraseToAnyPublisher()
  }
}
