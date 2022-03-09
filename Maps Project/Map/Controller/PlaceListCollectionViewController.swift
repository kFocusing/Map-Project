//
//  PlaceListCollectionViewController.swift
//  Maps Project
//
//  Created by Danylo Klymov on 07.03.2022.
//

import UIKit

class PlaceListCollectionViewController: UIViewController {
    
    //MARK: - Variables -
    private var collectionView: UICollectionView!
    private let itemsPerRow: CGFloat = 1
    private let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    var places = [PlaceModel]()
    
    //MARK: - Life Cycle-
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupCollectionView()
    }
    
    //MARK: - Private -
    private func calculateWidthforItem() -> CGFloat {
        let paddingWidth = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = self.view.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        return widthPerItem
    }
    
    private func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: calculateWidthforItem(),
                                          height: 140)
        layout.itemSize = CGSize(width: calculateWidthforItem(),
                                 height: UICollectionViewFlowLayout.automaticSize.height)
        layout.sectionInset = sectionInsets
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView .translatesAutoresizingMaskIntoConstraints = false
        collectionView .dataSource = self
        view.addSubview(collectionView)
        
        collectionView.pinEdges(to: self.view)
        PlaceCollectionViewCell.register(in: collectionView)
        collectionView.reloadData()
    }
    
    private func setupNavigationBar() {
        title = "List around places"
    }
}

// MARK: - Extensions -
// MARK: - UICollectionViewDataSource -
extension PlaceListCollectionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return places.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = PlaceCollectionViewCell.dequeueCellWithType(in: collectionView, indexPath: indexPath)
        let place = places[indexPath.row]
        cell.configure(with: place)
        return cell
    }
}
