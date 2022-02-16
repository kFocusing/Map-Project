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
    //MARK: - Lazy variables -
    lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 50
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        return locationManager
    }()
    
    //MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        } else {
            getMarkerAndCameraOnDefaultLocale()
        }
    }
    
    //MARK: - Private Functions -
    private func getMarkerAndCameraOnDefaultLocale() {
        let camera = GMSCameraPosition.camera(withLatitude: 47.843468, longitude: 35.130487, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        setDefaultMapSettings(map: mapView)
        getMarkerToLocation(latitude: 47.843468, longitude: 35.130487, map: mapView)
    }
    
    private func getMarkerAndCameraToLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 16.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        setDefaultMapSettings(map: mapView)
        getMarkerToLocation(latitude: latitude, longitude: longitude, map: mapView)
    }
    
    private func setDefaultMapSettings(map: GMSMapView) {
        map.settings.myLocationButton = true
        map.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        map.isMyLocationEnabled = true
        view = map
    }
    
    private func getMarkerToLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees, map: GMSMapView) {
        let marker = GMSMarker()
        let cordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        marker.position = cordinate
        reverseGeocode(coordinate: cordinate, marker: marker)
        marker.map = map
    }
    
    private func reverseGeocode(coordinate: CLLocationCoordinate2D, marker: GMSMarker) {
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            guard let address = response?.firstResult() else { return }
            let lines = address.lines ?? [""]
            marker.snippet = lines.joined(separator: ", ")
        }
    }
}


//MARK: - Extensions -
//MARK: - CLLocationManagerDelegate -
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
