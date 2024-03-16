//
//  Api.swift
//  Naukri Crypto
//
//  Created by Guru King on 16/03/2024.
//

import Foundation

enum Api{
    case fetch
}

extension Api:EndpointType{
    var method: HTTPMethod {
        switch self {
        case .fetch:
            return HTTPMethod.get
        }
    }
        var params: [String : String]? {
            switch self {
            case .fetch:
                return nil
            }
        }
        
        var baseURL: String {
            return "https://api.coingecko.com/api/v3/"
        }

        var path: String {
            switch self {
            case .fetch:
                return "coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h"
            }
        }
    }
