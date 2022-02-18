//
//  LocationInformation.swift
//  Maps Project
///Users/klymov/Desktop/Maps Project/Maps Project/Map/LocationRequest.swift
//  Created by Danylo Klymov on 17.02.2022.
//

import Foundation

// MARK: - LocationRequest -
struct PlacesInformation: Codable {
    let results: [PlaceInfromation]
    let status: String
}

// MARK: - someLocationRequest -
struct PlaceInfromation: Codable {
    let geometry: Geometry?
    let icon: String?
    let iconBackgroundColor: String?
    let name: String?
    let placeID: String?
    let priceLevel: Int?
    let rating: Double?
    let vicinity: String?

    enum CodingKeys: String, CodingKey {
        case geometry, icon
        case iconBackgroundColor = "icon_background_color"
        case name
        case placeID = "place_id"
        case priceLevel = "price_level"
        case rating
        case vicinity
    }
}

// MARK: - Geometry -
struct Geometry: Codable {
    let location: Location?
}

// MARK: - Location -
struct Location: Codable {
    let lat, lng: Double?
}
