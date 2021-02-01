//
//  File.swift
//  
//
//  Created by Emrah Akgül on 26.01.2021.
//

import Foundation

public protocol UserReposServiceProtocol {
    func getRepos(owner: String?, pageNumber:Int, perPage:Int,completion: @escaping (Result<[RepoItemDTO]?, Error>) -> Void)
}
