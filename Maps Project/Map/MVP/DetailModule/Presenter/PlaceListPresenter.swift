//
// PlaceListPresenter.swift
//  Maps Project
//
//  Created by Danylo Klymov on 30.03.2022.
//

import Foundation

protocol PlaceListViewProtocol: AnyObject {}

protocol PlaceListPresenterProtocol: AnyObject {
    init(view: PlaceListViewProtocol,
         router: RouterProtocol,
         places: [PlaceModel])
    func item(at index: Int) -> PlaceModel
    func itemsCount() -> Int
}

class PlaceListPresenter: PlaceListPresenterProtocol {
    //MARK: - Variables -
    weak var view: PlaceListViewProtocol?
    var router: RouterProtocol?
    private var places: [PlaceModel]
    
    //MARK: - Life Cycle -
    required init(view: PlaceListViewProtocol,
                  router: RouterProtocol,
                  places: [PlaceModel]) {
        self.view = view
        self.router = router
        self.places = places
    }
    
    //MARK: Internal
    func item(at index: Int) -> PlaceModel {
        return places[index]
    }
    
    func itemsCount() -> Int {
        return places.count
    }
}
