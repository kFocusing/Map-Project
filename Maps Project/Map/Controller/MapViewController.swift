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
    private let defaultCameraZoom: Float = 16
    private var mapView: GMSMapView!
    private var places = [PlaceModel]()
    
    //MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
        setupMapView()
    }
    
    //MARK: - Private -
    private func setupLocationManager() {
        LocationManager.shared.delegate = self
        LocationManager.shared.start()
    }
    
    private func setCameraToLocation(location: CLLocation) {
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
        PlacesService.shared.fetchNearbyPlaces(location: location) { [weak self] places in
            guard let places = places?.results else { return }
            self?.updatePlaces(placeInfromation: places)
        }
    }
    
    private func updatePlaces(placeInfromation: [PlaceModel]) {
        DispatchQueue.main.async {
            self.places = placeInfromation
            self.setAroundsMarkersInMap()
        }
    }
    
    private func setAroundsMarkersInMap() {
        for place in places {
            guard let lat = place.geometry?.location?.lat,
                  let lng = place.geometry?.location?.lng else { return }
            let cordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            
            
            let name = place.name ?? ""
            let vicinity = place.vicinity ?? ""
            let description = (placeName: name, placeAddress: vicinity)
            
            setMarkerToLocation(cordinate: cordinate, description: description)
        }
    }
    
    private func setMarkerToLocation(cordinate: CLLocationCoordinate2D,
                                     description: (placeName: String,
                                                   placeAddress: String)) {
        let marker = GMSMarker()
        marker.title = description.placeName
        marker.snippet = description.placeAddress
        marker.position = cordinate
        marker.map = mapView
    }
}

//MARK: - Extensions -
//MARK: - LocationManagerDelegate -
extension MapViewController: LocationManagerDelegate {
    func didUpdateLocation(location: CLLocation) {
            mapView.clear()
            setCameraToLocation(location: location)
            getAroundPlaces(location: location)
    }
}
