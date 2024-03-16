//
//  RequestFactory.swift
//  Naukri Crypto
//
//  Created by Guru King on 16/03/2024.
//

import Foundation

final class RequestFactory {

    static func request(endpoint: EndpointType) -> URLRequest {
        let urlString = endpoint.baseURL + endpoint.path
        let params = endpoint.params
        var components = URLComponents(string: urlString)
        if let params = params {
            components?.queryItems = params.map { element in URLQueryItem(name: element.key, value: element.value) }
        }
        var request = URLRequest(url: (components?.url)!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = endpoint.method.rawValue
        return request
    }
}
