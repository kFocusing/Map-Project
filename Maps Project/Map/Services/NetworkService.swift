//
//  NetworkService.swift
//  Maps Project
//
//  Created by Danylo Klymov on 29.01.2022.
//

import Foundation

class NetworkService {
    //MARK: - Static -
    static let shared = NetworkService()
    
    private init() {}
    
    //MARK: - Internal -
    func getData(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let session = URLSession.shared
        session.dataTask(with: url) { (data, _, error) in
            guard let data = data, error == nil else {
                completion(.failure(NetworkingError.failedResponseJSON))
                return
            }
            completion(.success(data))
        }.resume()
    }
    
    //MARK: - Enum -
    //MARK: - NetworkingError -
    private enum NetworkingError: Error {
        case failedResponseJSON
        case failedParseJSON
    }
}
