//
//  UIImageViewExtension.swift
//  Maps Project
//
//  Created by Danylo Klymov on 21.02.2022.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(with url: String?) {
        guard let stringUrl = url,
              let url = URL(string: stringUrl) else {
                  self.image = UIImage(named: "error404")
                  return
              }
        DispatchQueue.main.async {
            self.kf.setImage(with: url)
        }
    }
}
