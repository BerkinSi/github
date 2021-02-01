//
//  File.swift
//  
//
//  Created by Emrah Akgül on 26.01.2021.
//

import Foundation

public struct UserDTO: Decodable {
    public let id: Int?
    public let login: String?
    public let name: String?
    public let email: String?
    public let location: String?
    public let avatarURL: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case login = "login"
        case name = "name"
        case email = "email"
        case location = "location"
        case avatarURL = "avatar_url"
    }
    
}
