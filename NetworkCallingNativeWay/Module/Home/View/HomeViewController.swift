//
//  HomeViewController.swift
//  NetworkCallingNativeWay
//
//  Created by Shivanshu Verma on 21/05/23.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private let homeVM = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.homeVM.callApi()
        self.registerCell()
        self.reloadTableView()
    }
    private func registerCell() {
        self.tableView.register(UINib(nibName: HomeConstants.Cell.home, bundle: nil), forCellReuseIdentifier: HomeConstants.Cell.home)
    }
    private func reloadTableView() {
        self.homeVM.reloadTableView = { [weak self] in
            guard let self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.homeVM.model.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeConstants.Cell.home, for: indexPath) as! HomeTableViewCell
        cell.product = self.homeVM.getCellValue(at: indexPath)
        return cell
    }
}
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       245
    }
}
