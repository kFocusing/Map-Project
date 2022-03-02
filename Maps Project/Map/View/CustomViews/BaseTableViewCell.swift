//
//  BaseTableViewCell.swift
//  Maps Project
//
//  Created by Danylo Klymov on 01.03.2022.
//

import UIKit

class BaseTableViewCell: UITableViewCell, CellRegistable, CellDequeueReusable {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
