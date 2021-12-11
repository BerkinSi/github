//
//  AppDIContainer.swift
//  Github
//
//  Created by Emrah Akgül on 25.01.2021.
//

import Foundation
import GithubAPI

let appDIContainer = AppDIContainer()

final class AppDIContainer {
    
    let searchReposService: SearchReposServiceProtocol
    let userProfileService: UserProfileServiceProtocol
    let userReposService: UserReposServiceProtocol
    
    init() {
        self.searchReposService = SearchReposAPIService()
        self.userProfileService = UserProfileAPIService()
        self.userReposService = UserReposAPIService()
    }
}
