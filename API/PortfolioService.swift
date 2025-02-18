//
//  PreviewPortfolioService.swift
//  Bwallet
//
//  Created by Jun on 18/2/25.
//

import Combine
import Domain
import Service

final class PreviewPortfolioService: Service.PortfolioService {
  let networkClient: NetworkClient
  
  init(networkClient: NetworkClient) {
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
