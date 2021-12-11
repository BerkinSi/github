//
//  RepoTableViewCellPresentation.swift
//  Github
//
//  Created by Emrah Akgül on 26.01.2021.
//

import Foundation
import struct GithubAPI.RepoItemDTO

struct RepoTableViewCellPresentation {
    
    let imageUrl: String?
    let repoName: String?
    let ownerName: String?
    let programmingLanguage: String?
    let isPrivate: Bool?
    
    init(repoItemDTO: RepoItemDTO?) {
        self.imageUrl = repoItemDTO?.owner?.avatarURL
        self.repoName = repoItemDTO?.name
        self.ownerName = repoItemDTO?.owner?.login
        self.programmingLanguage = repoItemDTO?.programmingLanguage
        self.isPrivate = repoItemDTO?.isPrivate
    }
}
