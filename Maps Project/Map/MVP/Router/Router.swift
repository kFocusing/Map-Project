//
//  Router.swift
//  Maps Project
//
//  Created by Danylo Klymov on 30.03.2022.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func showMapViewController()
    func showPlaceList(places: [PlaceModel])
    func popToRoot()
}

class Router: RouterProtocol {
    
    //MARK: - Variables -
    var assemblyBuilder: AssemblyBuilderProtocol?
    var navigationController: UINavigationController?
    
    //MARK: - Life Cycle -
    init(navigationController: UINavigationController,
         assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    //MARK: - Internal -
    func showMapViewController() {
        guard let mapViewController =
                assemblyBuilder?.createMapModule(router: self) else { return }
        navigationController?.viewControllers = [mapViewController]
    }
    
    func showPlaceList(places: [PlaceModel]) {
        guard let placeListViewController =
                assemblyBuilder?.createPlaceListModule(router: self,
                                                       places: places) else { return }
        navigationController?.pushViewController(placeListViewController,
                                                 animated: true)
        
    }
    
    func popToRoot() {
        navigationController?.popViewController(animated: true)
    }
}
