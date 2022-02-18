//
//  GoogleService.swift
//  Maps Project
//
//  Created by Danylo Klymov on 15.02.2022.
//


import GoogleMaps
import GooglePlaces

class GoogleService {
    
    // MARK: - Shared instance -
    static let shared = GoogleService()
    
    // MARK: - Private properties -
    private let apiKey = "AIzaSyBoXjLdkEsN8eTWEMHCajqLavHxc7-s3Ms"
    
    // MARK: - Life Cycle -
    private init() {}
    
    // MARK: - Internal -
    func startServices() {
        GMSServices.provideAPIKey(apiKey)
        GMSPlacesClient.provideAPIKey(apiKey)
    }
}