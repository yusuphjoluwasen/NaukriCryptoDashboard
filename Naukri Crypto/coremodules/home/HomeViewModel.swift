//
//  HomeViewModel.swift
//  Naukri Crypto
//
//  Created by Guru King on 16/03/2024.
//

import Foundation

final class HomeViewModel: ObservableObject{
    
    private let repo: HomeRepositoryProtocol
    
    init(repo:HomeRepositoryProtocol) {
        self.repo = repo
    }
    
    func submitSelfVerification() async throws -> CoinList {
        let res =  try await repo.fetchCoins()
        return res
    }
}
