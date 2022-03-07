//
//  CellDequeueReusable&Registable.swift
//  Maps Project
//
//  Created by Danylo Klymov on 01.03.2022.
//

import UIKit

protocol CellDequeueReusable: UITableViewCell { }

protocol CellRegistable: UITableViewCell { }

extension CellRegistable {
    static func register(in tableView: UITableView) {
        tableView.register(Self.self, forCellReuseIdentifier: String(describing: self))
    }
    
    static func registerXIB(in tableView: UITableView) {
        tableView.register(UINib(nibName: String(describing: self), bundle: nil),
                           forCellReuseIdentifier: String(describing: self))
    }
}

extension CellDequeueReusable {
    static func dequeueCellWithType(in tableView: UITableView, indexPath: IndexPath) -> Self {
        return tableView.dequeueReusableCell(withIdentifier: String(describing: Self.self),
                                             for: indexPath) as! Self
    }
}
