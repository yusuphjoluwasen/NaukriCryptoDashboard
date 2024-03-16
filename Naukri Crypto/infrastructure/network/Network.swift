//
//  Network.swift
//  Naukri Crypto
//
//  Created by Guru King on 16/03/2024.
//

import Foundation
protocol NetworkingProtocol {
    func makeUrlRequest<T: Codable>(request: EndpointType?, returnType: T.Type) async throws -> T
}

struct Networking: NetworkingProtocol {
    func makeUrlRequest<T: Codable>(request: EndpointType?, returnType: T.Type) async throws -> T {
        guard let request = request else {
            throw RequestError.invalidUrl
        }
        let urlRequest = RequestFactory.request(endpoint: request)
        
        print("Request: ")
        print(urlRequest)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            
            let newData = Response(data: data)
            guard let decoded = newData.decode(returnType) else {
                throw RequestError.dataDecodingError
            }
            
            return decoded
        } catch {
            throw handleNetworkError(error)
        }
    }
    
    private func handleNetworkError(_ error: Error) -> Error {
        if let urlError = error as? URLError {
            if urlError.code == .notConnectedToInternet || urlError.code == .networkConnectionLost {
                return RequestError.connectivityError
            }
        }
        return RequestError.clientError
    }
}

