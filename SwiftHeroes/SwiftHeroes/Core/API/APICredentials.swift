//
//  APICredentials.swift
//  SwiftHeroes
//
//  Created by Djorkaeff Alexandre Vilela Pereira on 3/4/21.
//

import Foundation
import CryptoSwift

struct Credentials {
    
    static var publicKey: String {
        guard let path = Bundle.main.path(forResource: "Enviroment", ofType: "plist"),
              let dictionary = NSDictionary(contentsOfFile: path),
              let publicKey = dictionary["publicKey"] as? String else { return "" }
        
        return publicKey
    }
    
    static var privateKey: String {
        guard let path = Bundle.main.path(forResource: "Enviroment", ofType: "plist"),
              let dictionary = NSDictionary(contentsOfFile: path),
              let privateKey = dictionary["privateKey"] as? String else { return "" }
        
        return privateKey
    }
    
    static var marvel: [String: String] {
        let timestamp = String(NSDate().timeIntervalSince1970)
        let hash = "\(timestamp)\(privateKey)\(publicKey)".md5()
        
        return [
            "ts": timestamp,
            "apikey": publicKey,
            "hash": hash
        ]
    }
}
