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
    func update(with: CLLocation)
    func displayPlaces(_ places: [PlaceModel])
}

protocol MapPresenterProtocol: AnyObject {
    init(view: MapViewProtocol,
         networkService: NetworkService,
         router: RouterProtocol)
    func setupLocationManager()
    func getAroundPlaces(location: CLLocation)
    func tapPlaceListButton()
    func viewDidLoad()
}

class MapPresenter: MapPresenterProtocol {
    
    //MARK: - Variables -
    weak var view: MapViewProtocol?
    var router: RouterProtocol?
    let networkService: NetworkServiceProtocol!
    private var places = [PlaceModel]()
    
    //MARK: - Life Cycle -
    required init(view: MapViewProtocol,
                  networkService: NetworkService,
                  router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
    }
    
    //MARK: - Internal -
    func viewDidLoad() {
        setupLocationManager()
    }
    
    func setupLocationManager() {
        LocationManager.shared.delegate = self
        LocationManager.shared.start()
    }
    
    func getAroundPlaces(location: CLLocation) {
        PlacesService.shared.fetchNearbyPlaces(location: location,
                                               networkService: networkService) { [weak self] places in
            guard let places = places?.results else { return }
            self?.updatePlaces(places: places)
        }
    }
    
    func updatePlaces(places: [PlaceModel]) {
        DispatchQueue.main.async {
            self.places = places
            self.view?.displayPlaces(places)
        }
    }
    
    func tapPlaceListButton() {
        router?.showPlaceList(places: places)
    }
}

extension MapPresenter: LocationManagerDelegate {
    func didUpdateLocation(location: CLLocation) {
        view?.update(with: location)
        getAroundPlaces(location: location)
    }
}
