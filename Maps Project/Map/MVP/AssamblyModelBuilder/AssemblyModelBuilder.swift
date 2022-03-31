//
//  AssemblyModelBuilder.swift
//  Maps Project
//
//  Created by Danylo Klymov on 30.03.2022.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createMapModule(router: RouterProtocol) -> UIViewController
    func createPlaceListModule(router: RouterProtocol, places: [PlaceModel]) -> UIViewController
}

class AssemblyModelBuilder: AssemblyBuilderProtocol {
    
    //MARK: - Internal -
    func createMapModule(router: RouterProtocol) -> UIViewController {
        let view = MapViewController()
        let networkService = NetworkService()
        let presenter = MapPresenter(view: view,
                                     networkService: networkService,
                                     router: router)
        view.presenter = presenter
        return view
    }

    func createPlaceListModule(router: RouterProtocol,
                            places: [PlaceModel]) -> UIViewController {
        let view = PlaceListViewController()
        let presenter = PlaceListPresenter(view: view,
                                        router: router,
                                        places: places)
        view.presenter = presenter
        return view
    }
}
