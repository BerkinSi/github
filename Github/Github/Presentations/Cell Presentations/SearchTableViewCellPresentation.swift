//
//  SearchTableViewCellPresentation.swift
//  Github
//
//  Created by Emrah Akgül on 25.01.2021.
//

import Foundation
import struct GithubAPI.RepoItemDTO

struct SearchTableViewCellPresentation {
    let ownerID: Int?
    let imageUrl: String?
    let repoName: String?
    let ownerName: String?
    
    init(repoItemDTO: RepoItemDTO?) {
        self.imageUrl = repoItemDTO?.owner?.avatarURL
        self.repoName = repoItemDTO?.name
        self.ownerName = repoItemDTO?.owner?.login
        self.ownerID = repoItemDTO?.owner?.id
    }
}
