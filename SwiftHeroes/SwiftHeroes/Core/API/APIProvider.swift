//
//  APIProvider.swift
//  SwiftHeroes
//
//  Created by Jean Carlos Antônio Pereira dos Santos on 25/02/21.
//

import Foundation
import Combine

protocol APIProviderType {
    associatedtype Request: APIRequest
    func request(_ target: Request) -> URLSession.DataTaskPublisher
}

class APIProvider<Request: APIRequest>: APIProviderType {
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    @discardableResult
    func request(_ target: Request) -> URLSession.DataTaskPublisher {
        let req = target.urlRequest()
        let task = urlSession.dataTaskPublisher(for: req)
        
        return task
    }
}
