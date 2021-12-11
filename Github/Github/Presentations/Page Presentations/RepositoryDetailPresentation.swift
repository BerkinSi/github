//
//  RepositoryDetailPresentation.swift
//  Github
//
//  Created by Emrah Akgül on 25.01.2021.
//

import Foundation
import struct GithubAPI.RepoItemDTO

struct RepositoryDetailPresentation {
    
    let imageUrl: String?
    let repoName: String?
    let userName: String?
    let forksCount: Double?
    let programmingLanguage: String?
    
    init(repo: RepoItemDTO?) {
        self.imageUrl = repo?.owner?.avatarURL
        self.repoName = repo?.name
        self.userName = repo?.owner?.login
        self.forksCount = repo?.forksCount
        self.programmingLanguage = repo?.programmingLanguage
    }
}
