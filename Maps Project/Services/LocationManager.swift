//
//  LocationManager.swift
//  Maps Project
//
//  Created by Danylo Klymov on 17.02.2022.
//

import Foundation
import CoreLocation
import GoogleMaps

protocol LocationManagerDelegate: AnyObject {
    func didUpdateLocation(location: CLLocation)
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    // MARK: - Shared instance -
    static let shared = LocationManager()
    
    // MARK: - Variables -
    private let locationManager : CLLocationManager
    
    weak var delegate: LocationManagerDelegate?
    
    //MARK: - Life Cycle -
    override init() {
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        super.init()
        locationManager.delegate = self
    }
    
    // MARK: - Internal -
    func start() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    func stop() {
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        delegate?.didUpdateLocation(location: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
    }
}

