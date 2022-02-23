//
//  UIViewController Extension.swift
//  Maps Project
//
//  Created by Danylo Klymov on 22.02.2022.
//

import UIKit

extension UIViewController {
    static func viewController<T: UIViewController>(from storyboard: Storyboard) -> T {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: T.self)) as! T
        return viewController
    }
    
    
//    static func viewController<T>(from storyboardType: Storyboard, type: T.Type) -> T {
//            let storyboard = UIStoryboard(name: storyboardType.rawValue, bundle: nil)
//            let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: T.self)) as? T
//            assert(viewController != nil, "Can't get \(String(describing: T.self)) from storyboard \(storyboardType.rawValue)")
//            (viewController as? UIViewController)?.modalPresentationStyle = .fullScreen
//            return viewController!
//        }
}
