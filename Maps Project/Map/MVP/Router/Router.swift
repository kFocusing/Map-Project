//
//  Router.swift
//  Maps Project
//
//  Created by Danylo Klymov on 30.03.2022.
//

import UIKit

//MARK: - Protocols -
//MARK: - RouterMain -
protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assamblyBuilder: AssamblyBuilderProtocol? { get set }
}
//MARK: - RouterProtocol -
protocol RouterProtocol: RouterMain {
    func initialViewContoller()
    func showDetail(places: [PlaceModel])
    func popToRoot()
}

//MARK: - Class -
//MARK: - Router - 
class Router: RouterProtocol {
    
    //MARK: - Variables -
    var assamblyBuilder: AssamblyBuilderProtocol?
    var navigationController: UINavigationController?
    
    //MARK: - Life Cycle -
    init(navigationController: UINavigationController,
         assamblyBuilder: AssamblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assamblyBuilder = assamblyBuilder
    }
    
    //MARK: - Internal -
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
