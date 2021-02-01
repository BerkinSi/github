//
//  File.swift
//  
//
//  Created by Emrah Akgül on 25.01.2021.
//

import Foundation

public struct RepoItemDTO: Decodable {
    public let id: Int?
    public let name: String?
    public let fullName: String?
    public let owner: RepoOwnerDTO?
    public let forksCount: Double?
    public let defaultBranchName: String?
    public let programmingLanguage: String?
    public let isPrivate: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case owner = "owner"
        case forksCount = "forks_count"
        case defaultBranchName = "default_branch"
        case programmingLanguage = "language"
        case fullName = "full_name"
        case isPrivate = "private"
    }
}
