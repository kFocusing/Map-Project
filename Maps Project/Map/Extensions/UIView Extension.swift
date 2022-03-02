//
//  UIView Extension.swift
//  Maps Project
//
//  Created by Danylo Klymov on 22.02.2022.
//

import Foundation
import UIKit

//MARK: - Shadow -
extension UIView {
    func dropShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}

// MARK: - Layout -
extension UIView {
    //MARK: - Anchors -
    func pinEdges(to superView: UIView?,
                  topSpace: CGFloat = .zero,
                  leftSpace: CGFloat = .zero,
                  rightSpace: CGFloat = .zero,
                  bottomSpace: CGFloat = .zero) {
        guard let view = superView else {return}
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: topSpace),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftSpace),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -rightSpace),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -bottomSpace)
        ])
        view.setNeedsLayout()
    }
    
    func alignCentered(subview: UIView?,
                       xOffset: CGFloat = .zero,
                       yOffset: CGFloat = .zero) {
        guard let subview = subview else {return}
        subview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subview.centerXAnchor.constraint(equalTo: centerXAnchor, constant: xOffset),
            subview.centerYAnchor.constraint(equalTo: centerYAnchor, constant: yOffset)
        ])
        setNeedsLayout()
    }
}
