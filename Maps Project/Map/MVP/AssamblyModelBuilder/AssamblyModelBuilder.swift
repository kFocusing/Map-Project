//
//  AssamblyModelBuilder.swift
//  Maps Project
//
//  Created by Danylo Klymov on 30.03.2022.
//

import UIKit

protocol AssamblyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createDetailModule(router: RouterProtocol, places: [PlaceModel]) -> UIViewController
}

class AssamblyModelBuilder: AssamblyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = MapViewController()
        let networkService = NetworkService()
        let presenter = MapPresenter(view: view,
                                     networkService: networkService,
                                     router: router)
        view.presenter = presenter
        return view
    }

    func createDetailModule(router: RouterProtocol,
                            places: [PlaceModel]) -> UIViewController {
        let view = DetailViewController()
        let presenter = DetailPresenter(view: view,
                                        router: router,
                                        places: places)
        view.presenter = presenter
        return view
    }
}
