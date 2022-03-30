//
//  Router.swift
//  Maps Project
//
//  Created by Danylo Klymov on 30.03.2022.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assamblyBuilder: AssamblyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewContoller()
    func showDetail(places: [PlaceModel])
    func popToRoot()
}

class Router: RouterProtocol {
    
    var assamblyBuilder: AssamblyBuilderProtocol?
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController,
         assamblyBuilder: AssamblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assamblyBuilder = assamblyBuilder
    }
    
    
    func initialViewContoller() {
        if let navigationController = navigationController {
            guard let mainViewController = assamblyBuilder?.createMainModule(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }
    
    func showDetail(places: [PlaceModel]) {
        if let navigationController = navigationController {
            guard let detailViewController = assamblyBuilder?.createDetailModule(router: self, places: places) else { return }
            navigationController.pushViewController(detailViewController, animated: true)
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
}
