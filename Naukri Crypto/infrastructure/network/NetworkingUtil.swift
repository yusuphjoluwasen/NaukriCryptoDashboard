//
//  NetworkingUtil.swift
//  Naukri Crypto
//
//  Created by Guru King on 16/03/2024.
//

import Foundation

// MARK: Request
protocol EndpointType {
    var baseURL: String { get }
    var path: String { get }
    var params:[String:String]? { get }
    var method:HTTPMethod { get }
}

// MARK: Error
enum RequestError: Error {
    case clientError
    case serverError
    case noData
    case dataDecodingError
    case invalidUrl
    case connectivityError
    case genericError(String)
}

enum HTTPMethod: String {
    case post = "POST"
    case put = "PUT"
    case get = "GET"
    case delete = "DELETE"
    case patch = "PATCH"
}

extension RequestError:LocalizedError{
    public var errorDescription: String? {
        switch self {
        case .clientError, .noData, .dataDecodingError:
            return NetworkConstants.client
        case .serverError:
            return NetworkConstants.noservice
        case .invalidUrl:
            return NetworkConstants.invalidUrl
        case .connectivityError:
            return NetworkConstants.connectivity
        case .genericError(let value):
            return NSLocalizedString(value, comment: "")
        }
    }
}

// MARK: Response
public struct Response {
    fileprivate var data: Data
    public init(data: Data) {
        self.data = data
    }
}

extension Response {
    public func decode<T: Codable>(_ type: T.Type) -> T? {
        let jsonDecoder = JSONDecoder()
        do {
            let response = try jsonDecoder.decode(T.self, from: data)
            return response
        } catch let error {
            print("decoding error here: \(error)")
            return nil
        }
    }
}

// MARK: Constants
enum NetworkConstants{
    static let client = NSLocalizedString("Something went wrong", comment: "") //400 error
    static let noservice = NSLocalizedString("service not available", comment: "")
    static let invalidUrl = NSLocalizedString("invalid Url", comment: "")
    static let connectivity = NSLocalizedString("Please Check Your Internet Connection", comment: "")
}

extension Error {
    var isConnectivityError: Bool {
        let code = (self as NSError).code
        if code == NSURLErrorNotConnectedToInternet || code == NSURLErrorTimedOut {
            return true
        }
        return false
    }
}

extension Data {
    var prettyString: NSString? {
        return NSString(data: self, encoding: String.Encoding.utf8.rawValue) ?? nil
    }
}


