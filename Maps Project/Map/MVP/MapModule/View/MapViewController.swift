//
//  MapViewController.swift
//  Maps Project
//
//  Created by Danylo Klymov on 30.03.2022.
//

import UIKit
import GoogleMaps
import CoreLocation

class MapViewController: UIViewController {
    //MARK: - Variables -
    private lazy var mapView: GMSMapView = {
        let camera = GMSCameraPosition.camera(withLatitude: 0,
                                              longitude: 0,
                                              zoom: defaultCameraZoom)
        var mapView = GMSMapView()
        mapView = GMSMapView.map(withFrame: CGRect.zero,
                                 camera: camera)
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
        view.addSubview(mapView)
        return mapView
    }()
    private lazy var placeListButton: UIButton = {
        let placeListButton = UIButton(frame: CGRect(x: 0,
                                                     y: 0,
                                                     width: 55,
                                                     height: 55))
        placeListButton.backgroundColor = .white
        placeListButton.makeCircle()
        placeListButton.addDropShadow(shadowOpacity: 0.4,
                                      shadowRadius: 2,
                                      shadowOffset: CGSize(width: 0, height: 2),
                                      shadowColor: UIColor.black.cgColor)
        placeListButton.setImage(UIImage(systemName: "doc.plaintext"), for: .normal)
        placeListButton.tintColor = .darkGray
        placeListButton.translatesAutoresizingMaskIntoConstraints = false
        placeListButton.addTarget(self, action:
                                    #selector(placeListButtonPressed),
                                  for: .touchUpInside)
        return placeListButton
    }()
    private let defaultCameraZoom: Float = 16
    
    var presenter: MapPresenterProtocol!
    
    //MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutMap()
        layoutPlaceListButton()
        presenter.viewDidLoad()
    }
    
    //MARK: - Private -
    @objc private func placeListButtonPressed() {
        presenter.tapPlaceListButton()
    }
    
    private func layoutMap() {
        mapView.pinEdges(to: view)
    }
    
    private func layoutPlaceListButton() {
        view.addSubview(placeListButton)
        NSLayoutConstraint.activate([
            placeListButton.heightAnchor.constraint(equalToConstant: placeListButton.frame.size.height),
            placeListButton.widthAnchor.constraint(equalToConstant: placeListButton.frame.size.width),
            placeListButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                    constant: -120),
            placeListButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                      constant: -11)
        ])
    }
}

//MARK: - Extensions -
//MARK: - MapViewProtocol -
extension MapViewController: MapViewProtocol {
    func setCameraToLocation(position: GMSCameraPosition) {
        mapView.animate(to: position)
    }
    
    func setMarkerToLocation(cordinate: CLLocationCoordinate2D,
                                     description: (placeName: String,
                                                   placeAddress: String)) {
        let marker = GMSMarker()
        marker.title = description.placeName
        marker.snippet = description.placeAddress
        marker.position = cordinate
        marker.map = mapView
    }
    
    func clearMapView() {
        mapView.clear()
    }
    
    func update(with location: CLLocation) {
        setCameraToLocation(position: GMSCameraPosition(latitude: location.coordinate.latitude,
                                                        longitude: location.coordinate.longitude,
                                                        zoom: defaultCameraZoom))
        clearMapView()
    }
    
    func displayPlaces(_ places: [PlaceModel]) {
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
}