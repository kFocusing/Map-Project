//
//  PlacesService.swift
//  Maps Project
//
//  Created by Danylo Klymov on 18.02.2022.
//

import Foundation
import CoreLocation

class PlacesService {
    //MARK: - Static -
    static let shared = PlacesService()
    
    //MARK: - Life Cycle -
    private init() {}
    
    //MARK: - Internal -
    func fetchNearbyPlaces(location: CLLocation, networkService: NetworkServiceProtocol, completion: @escaping (_ places: PlacesResponse?) -> ()) {
        let urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(location.coordinate.latitude),\(location.coordinate.longitude)&radius=5000&type=restaurant&key=\(GoogleService.apiKey)"
        guard let url = URL(string: urlString) else { return }
        networkService.getData(url: url) { result in
            switch result {
            case .success(let data):
                let places: PlacesResponse? = Data.parseJson(data, expacting: PlacesResponse.self)
                completion(places)
            case .failure(let error):
                print(error)
            }
        }
    }
}
