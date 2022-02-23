//
//  UIImage Extension.swift
//  Maps Project
//
//  Created by Danylo Klymov on 21.02.2022.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func setImage(withURL: String?) {
        guard let withURL = withURL,
              let url = URL(string: withURL) else {
                  self.image = UIImage(named: "error404")
                  return
              }
        DispatchQueue.main.async {
            self.kf.setImage(with: url)
        }
    }
}
