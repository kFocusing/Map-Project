//
//  MapViewController.swift
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
    private lazy var placeListButton: UIButton = {
        let placeListButton = UIButton(frame: CGRect(x: 0,
                                                     y: 0,
                                                     width: 50,
                                                     height: 50))
        placeListButton.backgroundColor = .white
        placeListButton.addDropShadow(shadowOpacity: 0.4,
                                      shadowRadius: 2,
                                      shadowOffset: CGSize(width: 0.5, height: 1),
                                      shadowColor: UIColor.black.cgColor)
        placeListButton.setImage(UIImage(systemName: "doc.plaintext"), for: .normal)
        placeListButton.tintColor = .darkGray
        placeListButton.translatesAutoresizingMaskIntoConstraints = false
        placeListButton.addTarget(self, action:
                                    #selector(placeListButtonPressed),
                                  for: .touchUpInside)
        return placeListButton
    }()
    
    //MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
        setupMapView()
        addPlaceListButton()
        layoutPlaceListButton()
    }
    
    //MARK: - Private -
    @objc private func placeListButtonPressed() {
        navigateToPlaceList()
    }
    
    private func addPlaceListButton() {
        view.addSubview(placeListButton)
    }
    
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
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(mapView)
        mapView.pinEdges(to: view)
    }
    
    private func getAroundPlaces(location: CLLocation) {
        PlacesService.shared.fetchNearbyPlaces(location: location) { [weak self] places in
            guard let places = places?.results else { return }
            self?.updatePlaces(placeInfromation: places)
        }
    }
    
    private func updatePlaces(placeInfromation: [PlaceModel]) {
        DispatchQueue.main.async { [weak self] in
            self?.mapView.clear()
            self?.places = placeInfromation
            self?.setAroundsMarkersInMap()
        }
    }
    
    private func setAroundsMarkersInMap() {
        for place in places {
            guard let lat = place.geometry?.location?.lat,
                  let lng = place.geometry?.location?.lng else { return }
            let name = place.name ?? ""
            let vicinity = place.vicinity ?? ""
            let description = (placeName: name, placeAddress: vicinity)
            let cordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
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
    
    private func layoutPlaceListButton() {
        view.addSubview(placeListButton)
        NSLayoutConstraint.activate([
            placeListButton.heightAnchor.constraint(equalToConstant: 55),
            placeListButton.widthAnchor.constraint(equalToConstant: 55),
            placeListButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120),
            placeListButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -11)
        ])
        placeListButton.makeCircle()
    }
    
    private func navigateToPlaceList() {
        let placeListViewController: PlaceListViewController = .viewController(from: .placeList)
        placeListViewController.places = places
        self.navigationController?.pushViewController(placeListViewController,
                                                      animated: true)
    }
}

//MARK: - Extensions -
//MARK: - LocationManagerDelegate -
extension MapViewController: LocationManagerDelegate {
    func didUpdateLocation(location: CLLocation) {
        setCameraToLocation(location: location)
        getAroundPlaces(location: location)
    }
}

