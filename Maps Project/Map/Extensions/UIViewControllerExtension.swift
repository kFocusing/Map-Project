//
//  UIViewControllerExtension.swift
//  Maps Project
//
//  Created by Danylo Klymov on 22.02.2022.
//

import UIKit

extension UIViewController {
    static func viewController<T: UIViewController>(from storyboard: Storyboard) -> T {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier:
                                                                    String(describing: T.self)) as! T
        return viewController
    }
}
