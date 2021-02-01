//
//  File.swift
//  
//
//  Created by Emrah Akgül on 25.01.2021.
//

import Foundation

struct UserProfileRequest: GetRequest {
    public var path: String = "/users/"
    public var parameters =  [URLQueryItem]()
    public var headers: [String : String] = [:]
    
    init(name: String?) {
        path = "/users/" + (name ?? "")
    }
}
