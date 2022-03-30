//
//  DetailPresenter.swift
//  Maps Project
//
//  Created by Danylo Klymov on 30.03.2022.
//

import Foundation

protocol DetailViewProtocol: AnyObject {
    func succes()
    func failure(error: Error)
}

protocol DetailViewPresenterProtocol: AnyObject {
    init(view: DetailViewProtocol,
         router: RouterProtocol,
         places: [PlaceModel])
    var places: [PlaceModel] { get set }
}

class DetailPresenter: DetailViewPresenterProtocol {
    
    weak var view: DetailViewProtocol?
    var router: RouterProtocol?
    var places: [PlaceModel]
    
    required init(view: DetailViewProtocol,
                  router: RouterProtocol,
                  places: [PlaceModel]) {
        self.view = view
        self.router = router
        self.places = places
    }
}
