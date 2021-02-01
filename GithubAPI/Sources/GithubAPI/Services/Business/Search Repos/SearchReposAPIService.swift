//
//  File.swift
//  
//
//  Created by Emrah Akgül on 25.01.2021.
//

import Foundation

public final class SearchReposAPIService: SearchReposServiceProtocol {
    public init() {}
    
    public func searchRepos(text: String?, pageNumber:Int, perPage:Int, completion: @escaping (Result<SearchReposContainerDTO?, Error>) -> Void) {
        
        guard let searchText = text, !searchText.isEmpty else { return }
        
        let textQueryItem = URLQueryItem(name: "q", value: text ?? "")
        let pageQueryItem = URLQueryItem(name: "page", value: String(pageNumber))
        let perPageQueryItem = URLQueryItem(name:"per_page" , value:String(perPage))
        
        let parameters = [textQueryItem, pageQueryItem, perPageQueryItem]
        let searchReposRequest = SearchReposRequest(parameters: parameters, headers: [:])
        
        NetworkManager.default.makeRequest(request: searchReposRequest) { (searchReposContainer: SearchReposContainerDTO?, error: Error?) in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let searchReposContainer = searchReposContainer {
                completion(.success(searchReposContainer))
            }
            else {
                completion(.failure(ServiceError.notRetrieved))
            }
        }
    }
}
