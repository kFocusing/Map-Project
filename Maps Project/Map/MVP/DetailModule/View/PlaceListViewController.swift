//
//  PlaceListViewController.swift
//  Maps Project
//
//  Created by Danylo Klymov on 30.03.2022.
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
    
    var presenter: PlaceListPresenterProtocol!
    
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

extension PlaceListViewController: PlaceListViewProtocol { }

extension PlaceListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.itemsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PlaceXibTableViewCell.dequeueCell(in: tableView, indexPath: indexPath)
        cell.configure(with: presenter.item(at: indexPath.item))
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
