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
    static func dequeueCell(in tableView: UITableView, indexPath: IndexPath) -> Self {
        return tableView.dequeueReusableCell(withIdentifier: String(describing: Self.self),
                                             for: indexPath) as! Self
    }
}


protocol CollectionCellDequeueReusable: UICollectionViewCell { }

protocol CollectionCellRegistable: UICollectionViewCell { }

extension CollectionCellRegistable {
    static func register(in collectionView: UICollectionView) {
        collectionView.register(Self.self, forCellWithReuseIdentifier: String(describing: self))
    }
}

extension CollectionCellDequeueReusable {
    static func dequeueCellWithType(in collectionView: UICollectionView, indexPath: IndexPath) -> Self {
        return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: Self.self),
                                                  for: indexPath) as! Self
    }
}
