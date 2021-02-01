//
//  File.swift
//  
//
//  Created by Emrah Akgül on 25.01.2021.
//

import Foundation

public class UserProfileAPIService: UserProfileServiceProtocol {
    public init() {}
    
    public func getUserProfile(userName: String? ,completion: @escaping (Result<UserDTO?, Error>) -> Void) {
        let userProfileRequest = UserProfileRequest(name: userName)
        NetworkManager.default.makeRequest(request: userProfileRequest) { (userDTO: UserDTO?, error: Error?) in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let userDTO = userDTO {
                completion(.success(userDTO))
            }
            else {
                completion(.failure(ServiceError.notRetrieved))
            }
        }
    }
}
