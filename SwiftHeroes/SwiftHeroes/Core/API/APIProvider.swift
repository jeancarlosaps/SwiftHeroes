//
//  APIProvider.swift
//  SwiftHeroes
//
//  Created by Jean Carlos Antônio Pereira dos Santos on 25/02/21.
//

import Foundation

protocol APIProviderType {
    typealias Completion = (_ result: Result<APIResponse, APIError>) -> Void
    associatedtype Request: APIRequest
    func request(_ target: Request, completion: @escaping Completion) -> URLSessionDataTask?
}

class APIProvider<Request: APIRequest>: APIProviderType {
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    @discardableResult
    func request(_ target: Request, completion: @escaping Completion) -> URLSessionDataTask? {
        let req = target.urlRequest()
        let task = urlSession.dataTask(with: req) {data, _, error in
            if let _ = error {
                completion(.failure(.unknown))
            }
            
            completion(.success(APIResponse(statusCode: 200, data: data)))
        }
        
        task.resume()
        
        return task
    }
}
