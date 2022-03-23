//
//  MapPresenter.swift
//  Maps Project
//
//  Created by Danylo Klymov on 10.03.2022.
//

import Foundation

protocol MapViewProtocol: AnyObject {
    
    func setGreeting(greeting: String)
}

protocol MapViewPresenter: AnyObject {
    
    init(view: MapViewProtocol, places: )
}
