//
//  File.swift
//  
//
//  Created by Emrah Akgül on 25.01.2021.
//

import Foundation

public protocol UserProfileServiceProtocol {
    func getUserProfile(userName: String? ,completion: @escaping (Result<UserDTO?, Error>) -> Void)
}
