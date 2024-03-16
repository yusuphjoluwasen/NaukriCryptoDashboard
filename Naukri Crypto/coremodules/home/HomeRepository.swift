//
//  HomeRepository.swift
//  Naukri Crypto
//
//  Created by Guru King on 16/03/2024.
//

import Foundation
typealias CoinList = [Coin]

protocol HomeRepositoryProtocol {
    func fetchCoins() async throws -> CoinList
}

final class HomeRepository: HomeRepositoryProtocol {
    
    let network: NetworkingProtocol
    
    init(network: NetworkingProtocol) {
        self.network = network
    }
    
    func fetchCoins() async throws -> CoinList{
        let req = Api.fetch
        return try await network.makeUrlRequest(request: req, returnType: CoinList.self)
    }
}
