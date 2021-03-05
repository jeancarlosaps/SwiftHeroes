//
//  APIRequest.swift
//  SwiftHeroes
//
//  Created by Jean Carlos Antônio Pereira dos Santos on 25/02/21.
//

import Foundation

protocol APIRequest {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod  { get }
    var headers: [String: String]? { get }
    var task: HTTPTask { get }
}

extension APIRequest {
    func urlRequest() -> URLRequest {
        var url: URL
        
        if path.isEmpty {
            url = baseURL
        } else {
            url = baseURL.appendingPathComponent(path)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request = request.encoded(parameters: Credentials.marvel)
        
        switch task {
        case .requestPlain:
            return request
        case .requestParameters(var parameters):
            let req = request.encoded(parameters: parameters.merge(dict: Credentials.marvel))
            return req
        }
    }
}

extension URLRequest {
    func encoded(parameters: [String: Any]?) -> URLRequest {
        guard let url = url else {
            return self
        }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        let queryItems = parameters?.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        components?.queryItems = queryItems
        
        return URLRequest(url: components?.url ?? url)
    }
}

extension Dictionary {
    mutating func merge(dict: [Key: Value]) -> Dictionary {
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
        return self
    }
}
