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
    private var locationManager = LocationManager.shared
    private let defaultCameraZoom: Float = 16
    private var mapView = GMSMapView()
    private var networkService = NetworkService.shared
    private var places = [PlaceInfromation]()
    
    
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
    
    private func getAroundPlaces(location: CLLocation) {
        let urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(location.coordinate.latitude),\(location.coordinate.longitude)&radius=5000&type=restaurant&key=AIzaSyBoXjLdkEsN8eTWEMHCajqLavHxc7-s3Ms"
        
        guard let url = URL(string: urlString) else { return }
        NetworkService.shared.getData(url: url) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let placeInfromation):
                self.updatePlaces(placeInfromation: placeInfromation)
            }
        }
    }
    
    private func updatePlaces(placeInfromation: [PlaceInfromation]) {
        DispatchQueue.main.async {
            self.places = placeInfromation
            self.getMarkersInMap()
        }
    }
    
    private func getMarkersInMap() {
        for place in places {
            guard let lat = place.geometry?.location?.lat,
                  let lng = place.geometry?.location?.lng else { return }
            let cordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            
            
            let name = place.name ?? ""
            let vicinity = place.vicinity ?? ""
            let description = (name, vicinity)
            
            getMarkerToLocation(cordinate: cordinate, description: description)
        }
    }
    
    private func getMarkerToLocation(cordinate: CLLocationCoordinate2D, description: (String, String)) {
        let marker = GMSMarker()
        marker.title = description.0
        marker.snippet = description.1
        marker.position = cordinate
        marker.map = mapView
    }
}

//MARK: - Extensions -
//MARK: - LocationManagerDelegate -
extension MapViewController: LocationManagerDelegate {
    func didUpdateLocation(location: CLLocation) {
            mapView.clear()
            getCameraToLocation(location: location)
            getAroundPlaces(location: location)
    }
}
