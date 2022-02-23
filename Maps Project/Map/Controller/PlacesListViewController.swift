//
//  PlaceListViewController.swift
//  Maps Project
//
//  Created by Danylo Klymov on 21.02.2022.
//

import UIKit

class PlaceListViewController: UIViewController {
    
    //MARK: - Variables -
    private lazy var placeListTableView: UITableView = {
        let placeListTableView = UITableView()
        placeListTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(placeListTableView)
        return placeListTableView
    }()
    var places = [PlaceModel]()
    
    
    //MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
}


//MARK: - Extensions -
//MARK: - UITableViewDataSource -
extension PlaceListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell", for: indexPath) as! PlaceViewCell
        let place = places[indexPath.row]
        cell.configure(with: place)
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}















protocol CellDequeueReusable: UITableViewCell {
    
}

protocol CellRegistable: UITableViewCell {
    
}

/*
 let cell = PlaceViewCell.cell(on: tableView, at: indexPath)
 */

/*
private func setupTableView() {
    // TRUE!
//        PlaceViewCell.register(in tableView: tableView)

    // FALSE
//        UITableView().register(UINib(nibName: "name", bundle: nil), forCellReuseIdentifier: "identifier")
}
 */
