//
//  PortfolioService.swift
//  Bwallet
//
//  Created by Jun on 18/2/25.
//

import Combine
import Domain
import Service

final class PortfolioService: Service.PortfolioService {
  var networkClient: any Service.NetworkClient
  
  init(networkClient: any Service.NetworkClient) {
    self.networkClient = networkClient
  }
  
  func getAllAssets() -> AnyPublisher<[Asset], PortfolioServiceError> {
    let router = PortfolioAPI.getAllAssets
    
    return networkClient.request(router)
      .mapError { error in
        return PortfolioServiceError.internalError(error.localizedDescription)
      }
      .eraseToAnyPublisher()
  }
}
