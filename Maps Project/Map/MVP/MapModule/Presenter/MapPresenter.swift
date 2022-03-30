//
//  MapPresenter.swift
//  Maps Project
//
//  Created by Danylo Klymov on 30.03.2022.
//

import UIKit
import GoogleMaps
import CoreLocation

protocol MapViewProtocol: AnyObject {
    func setCameraToLocation(position: GMSCameraPosition)
    func clearMapView()
    func setMarkerToLocation(cordinate: CLLocationCoordinate2D,
                                     description: (placeName: String,
                                                   placeAddress: String))
}

protocol MapViewPresenterProtocol: AnyObject {
    init(view: MapViewProtocol,
         networkService: NetworkService,
         router: RouterProtocol)
    func setCameraToLocation(location: CLLocation)
    func setupLocationManager()
    func getAroundPlaces(location: CLLocation)
    func updatePlaces(placeInfromation: [PlaceModel])
    func setAroundsMarkersInMap()
    func tapPlaceListButton()
    func viewDidLoad()
}

class MapPresenter: MapViewPresenterProtocol {
    weak var view: MapViewProtocol?
    var router: RouterProtocol?
    let networkService: NetworkServiceProtocol!
    var places = [PlaceModel]()
    
    required init(view: MapViewProtocol,
                  networkService: NetworkService,
                  router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
    }
    
    func viewDidLoad() {
        setupLocationManager()
    }
    
    func setCameraToLocation(location: CLLocation) {
        let position = GMSCameraPosition(latitude: location.coordinate.latitude,
                                         longitude: location.coordinate.longitude,
                                         zoom: defaultCameraZoom)
        self.view?.setCameraToLocation(position: position)
    }
    
    func setupLocationManager() {
        LocationManager.shared.delegate = self
        LocationManager.shared.start()
    }
    
    func getAroundPlaces(location: CLLocation) {
        PlacesService.shared.fetchNearbyPlaces(location: location) { [weak self] places in
            guard let places = places?.results else { return }
            self?.updatePlaces(placeInfromation: places)
        }
    }
    
    func updatePlaces(placeInfromation: [PlaceModel]) {
        DispatchQueue.main.async {
            self.view?.clearMapView()
            self.places = placeInfromation
            self.setAroundsMarkersInMap()
        }
    }
    
    func setAroundsMarkersInMap() {
        for place in places {
            guard let lat = place.geometry?.location?.lat,
                  let lng = place.geometry?.location?.lng else { return }
            let name = place.name ?? ""
            let vicinity = place.vicinity ?? ""
            let description = (placeName: name, placeAddress: vicinity)
            let cordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            view?.setMarkerToLocation(cordinate: cordinate, description: description)
        }
    }
    
    func tapPlaceListButton() {
        router?.showDetail(places: places)
    }
}

//MARK: - Extensions -
//MARK: - LocationManagerDelegate -
extension MapPresenter: LocationManagerDelegate {
    func didUpdateLocation(location: CLLocation) {
        setCameraToLocation(location: location)
        getAroundPlaces(location: location)
    }
}
