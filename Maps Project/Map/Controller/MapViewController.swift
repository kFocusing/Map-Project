//
//  ViewController.swift
//  Maps Project
//
//  Created by Danylo Klymov on 15.02.2022.
//

import CoreLocation
import GoogleMaps
import UIKit

class MapViewController: UIViewController {

    lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 50
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        return locationManager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMarkerAndCameraOnDefaultLocale()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
        
    }
    
    private func getMarkerAndCameraOnDefaultLocale() {
        let camera = GMSCameraPosition.camera(withLatitude: 47.843468, longitude: 35.130487, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        setDefaultMapSettings(map: mapView)
    }
    
    private func getMarkerAndCameraToLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 16.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        setDefaultMapSettings(map: mapView)
    }
    
    private func setDefaultMapSettings(map: GMSMapView) {
        map.settings.myLocationButton = true
        map.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        map.isMyLocationEnabled = true
        view = map
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        getMarkerAndCameraToLocation(latitude: location.coordinate.latitude,
                            longitude: location.coordinate.longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
