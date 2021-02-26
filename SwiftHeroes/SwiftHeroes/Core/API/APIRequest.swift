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
        
        switch task {
        case .requestPlain:
            return request
        case .requestParameters(let parameters):
            return request.encoded(parameters: parameters)
        }
    }
}

extension URLRequest {
    func encoded(parameters: [String: Any]?) -> URLRequest {
        guard let url = url else {
            return self
        }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        components?.query = parameters?.compactMap{ "\($0.key)=\($0.value)" }.joined(separator: "&").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        return URLRequest(url: components?.url ?? url)
    }
}
