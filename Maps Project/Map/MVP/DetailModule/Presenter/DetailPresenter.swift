//
//  DetailPresenter.swift
//  Maps Project
//
//  Created by Danylo Klymov on 30.03.2022.
//

import Foundation

//MARK: - Protocols -
//MARK: - DetailViewProtocol -
protocol DetailViewProtocol: AnyObject {
    func succes()
    func failure(error: Error)
}

//MARK: - DetailViewPresenterProtocol -
protocol DetailViewPresenterProtocol: AnyObject {
    init(view: DetailViewProtocol,
         router: RouterProtocol,
         places: [PlaceModel])
    var places: [PlaceModel] { get set }
}

//MARK: - Class -
//MARK: - DetailPresenter -
class DetailPresenter: DetailViewPresenterProtocol {
    
    //MARK: - Variables -
    weak var view: DetailViewProtocol?
    var router: RouterProtocol?
    var places: [PlaceModel]
    
    //MARK: - Life Cycle -
    required init(view: DetailViewProtocol,
                  router: RouterProtocol,
                  places: [PlaceModel]) {
        self.view = view
        self.router = router
        self.places = places
    }
}
