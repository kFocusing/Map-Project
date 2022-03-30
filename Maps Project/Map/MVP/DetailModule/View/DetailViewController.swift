//
//  DetailViewController.swift
//  Maps Project
//
//  Created by Danylo Klymov on 30.03.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
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
    
    var presenter: DetailViewPresenterProtocol!
    
    //MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
    }
    
    //MARK: - Private -
    private func setupTableView() {
        layoutTableView()
        PlaceXibTableViewCell.registerXIB(in: tableView)
        tableView.reloadData()
    }
    
    private func layoutTableView() {
        tableView.pinEdges(to: self.view)
    }
    
    private func setupNavigationBar() {
        title = "List around places"
    }
}

//MARK: - Extension -
//MARK: - DetailViewProtocol -
extension DetailViewController: DetailViewProtocol {
    func succes() {
        tableView.reloadData()
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}
//MARK: - UITableViewDataSource, UITableViewDelegate -
extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PlaceXibTableViewCell.dequeueCell(in: tableView, indexPath: indexPath)
        let place = presenter.places[indexPath.item]
        cell.selectionStyle = .none
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
