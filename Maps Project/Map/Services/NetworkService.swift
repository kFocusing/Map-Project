//
//  NetworkService.swift
//  Maps Project
//
//  Created by Danylo Klymov on 29.01.2022.
//

import Foundation

protocol NetworkServiceProtocol {
    func getData(url: URL, completion: @escaping (Result<Data, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    //MARK: - Life Cycle -
    init() {}
    
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
    
    //MARK: - NetworkingError -
    private enum NetworkingError: Error {
        case failedResponseJSON
        case failedParseJSON
    }
}
