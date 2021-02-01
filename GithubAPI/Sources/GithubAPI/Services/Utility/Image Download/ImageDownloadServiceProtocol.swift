//
//  File.swift
//  
//
//  Created by Emrah Akgül on 28.01.2021.
//

import Foundation

public protocol ImageDownloaderServiceProtocol {
    func fetchImage(url: String, completion: @escaping (Result<Data?, Error>) -> Void)
}

public class ImageDownloaderService: ImageDownloaderServiceProtocol {
    public init() {}
    
    public func fetchImage(url: String, completion: @escaping (Result<Data?, Error>) -> Void) {
        guard let _url = URL(string: url) else {
            completion(.failure(ServiceError.notRetrieved))
            return
        }
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: _url)
            DispatchQueue.main.async {
                if let downloadedData = data {
                    completion(.success(downloadedData))
                }
                else {
                    completion(.failure(ServiceError.notRetrieved))
                }
            }
        }
    }
}
