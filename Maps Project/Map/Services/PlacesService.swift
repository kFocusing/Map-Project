//
//  PlacesService.swift
//  Maps Project
//
//  Created by Danylo Klymov on 18.02.2022.
//

import Foundation
import CoreLocation

class PlacesService {
    
    private let baseURL = ""
    
    //MARK: - Static -
    static let shared = PlacesService()
    
    private init() {}
    
    func fetchNearbyPlaces(location: CLLocation, completion: @escaping (_ places: PlacesResponse?) -> ()) {
        let urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(location.coordinate.latitude),\(location.coordinate.longitude)&radius=5000&type=restaurant&key=\(GoogleService.apiKey)"
        guard let url = URL(string: urlString) else { return }
        NetworkService.shared.getData(url: url) { result in
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
