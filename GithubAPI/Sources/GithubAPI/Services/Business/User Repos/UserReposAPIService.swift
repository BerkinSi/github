//
//  File.swift
//  
//
//  Created by Emrah Akgül on 26.01.2021.
//

import Foundation

public class UserReposAPIService: UserReposServiceProtocol {
    public init() {}
    
    public func getRepos(owner: String?, pageNumber: Int, perPage: Int, completion: @escaping (Result<[RepoItemDTO]?, Error>) -> Void) {
        
        let page = URLQueryItem(name: "page", value: String(pageNumber))
        let perPage = URLQueryItem(name:"per_page" , value:String(perPage))
        
        let parameters = [page,perPage]
        let userReposRequest = UserReposRequest(name: owner, parameters: parameters, headers: [:])
        NetworkManager.default.makeRequest(request: userReposRequest) { (userRepos: [RepoItemDTO]?, error: Error?) in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let userRepos = userRepos {
                completion(.success(userRepos))
            }
            else {
                completion(.failure(ServiceError.notRetrieved))
            }
        }
    }
}
