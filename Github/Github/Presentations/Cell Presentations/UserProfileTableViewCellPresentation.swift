//
//  UserDataTableViewCellPresentation.swift
//  Github
//
//  Created by Emrah Akgül on 26.01.2021.
//

import Foundation
import GithubAPI

struct UserProfileTableViewCellPresentation {
    
    let imageUrl: String?
    let username: String?
    let email: String?
    let name: String?
    
    init(userDTO: UserDTO?) {
        self.name = userDTO?.name
        self.email = userDTO?.email
        self.username = userDTO?.login
        self.imageUrl = userDTO?.avatarURL
    }
}
