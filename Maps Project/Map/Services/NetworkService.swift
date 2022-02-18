//
//  NetworkService.swift
//  NatifeTest
//
//  Created by Danylo Klymov on 29.01.2022.
//

import Foundation

class NetworkService {
    //MARK: - Static -
    static let shared = NetworkService()
    
    //MARK: - Internal -
    func getData(url: URL, completion: @escaping (Result<[PlaceInfromation], Error>) -> Void) {
        let session = URLSession.shared
        session.dataTask(with: url) { (data, _, error) in
            guard let data = data, error == nil else {
                completion(.failure(NetworkingError.failedResponseJSON))
                return
            }
            if let someLocationRequest = self.parseJson(data) {
                let placesArray = someLocationRequest.results
                completion(.success(placesArray))
            } else {
                completion(.failure(NetworkingError.failedParseJSON))
            }
        }.resume()
    }
    
    //MARK: - Private -
    private func parseJson(_ data: Data) -> PlacesInformation? {
        let decoder = JSONDecoder()
        do {
            let decodateData = try decoder.decode(PlacesInformation.self, from: data)
            return decodateData
        } catch {
            return nil
        }
    }
    
    //MARK: - Enum -
    //MARK: - NetworkingError -
    private enum NetworkingError: Error {
        case failedResponseJSON
        case failedParseJSON
    }
}
