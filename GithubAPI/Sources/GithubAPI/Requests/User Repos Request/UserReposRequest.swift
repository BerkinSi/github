//
//  File.swift
//  
//
//  Created by Emrah Akgül on 26.01.2021.
//

import Foundation

struct UserReposRequest: GetRequest {
    public var path: String = "/users/{0}/repos"
    public var parameters =  [URLQueryItem]()
    public var headers: [String : String] = [:]
    
    init(name: String?, parameters: [URLQueryItem], headers: [String: String]) {
        path = path.replacingOccurrences(of: "{0}", with: name ?? "")
        self.parameters = parameters
        self.headers = headers
    }
}
