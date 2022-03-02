//
//  PlaceListViewController.swift
//  Maps Project
//
//  Created by Danylo Klymov on 21.02.2022.
//

import UIKit

class PlaceListViewController: UIViewController {
    
    //MARK: - Variables -
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero,
                                style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        view.addSubview(table)
        return table
    }()
    var places = [PlaceModel]()
    
    
    //MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "List around places"
        
        setupTableView()
    }
    
    private func setupTableView() {
        layoutTableView()
        PlaceViewCell.register(in: tableView)
        tableView.reloadData()
    }
   
    private func layoutTableView() {
        tableView.pinEdges(to: self.view)
    }
}


//MARK: - Extensions -
//MARK: - UITableViewDataSource -
extension PlaceListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PlaceViewCell.dequeueCellWithType(in: tableView, indexPath: indexPath)
        let place = places[indexPath.row]
        cell.configure(with: place)
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
