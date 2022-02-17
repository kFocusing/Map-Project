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
    
    //MARK: - Variables -
    private var locationManager = LocationManager()
    private let defaultCameraZoom: Float = 16
    private var currentLocation: CLLocation?
    private var mapView = GMSMapView()
    
    //MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
        setupMapView()
    }
    
    //MARK: - Private -
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.start()
    }
    
    private func getCameraToLocation(location: CLLocation) {
        let position = GMSCameraPosition(latitude: location.coordinate.latitude,
                                         longitude: location.coordinate.longitude,
                                         zoom: defaultCameraZoom)
        mapView.animate(to: position)
    }
    
    
    private func setupMapView() {
        let camera = GMSCameraPosition.camera(withLatitude: 0, longitude: 0, zoom: defaultCameraZoom)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.setMinZoom(14, maxZoom: 20)
        mapView.settings.compassButton = true
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.settings.scrollGestures = true
        mapView.settings.zoomGestures = true
        mapView.settings.rotateGestures = true
        mapView.settings.tiltGestures = true
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.isIndoorEnabled = false
        self.view = mapView
    }
    
    // remake for google places
    private func getMarkerToLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees, map: GMSMapView) {
        let marker = GMSMarker()
        let cordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        marker.position = cordinate
        reverseGeocode(coordinate: cordinate, marker: marker)
        marker.map = map
    }
    
    private func reverseGeocode(coordinate: CLLocationCoordinate2D, marker: GMSMarker? = nil) {
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            guard let address = response?.firstResult() else { return }
            let lines = address.lines ?? [""]
            marker?.snippet = lines.joined(separator: ", ")
        }
    }
}


extension MapViewController : LocationManagerDelegate {
    func didUpdateLocation(location: CLLocation) {
        getCameraToLocation(location: location)
    }
}
