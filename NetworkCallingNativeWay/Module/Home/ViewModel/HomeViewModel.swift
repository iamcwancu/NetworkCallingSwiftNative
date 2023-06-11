//
//  HomeViewModel.swift
//  NetworkCallingNativeWay
//
//  Created by Shivanshu Verma on 21/05/23.
//

import Foundation

class HomeViewModel {
    /// closure to reload the table view in ViewController
    var reloadTableView: (() -> Void)?
    var model = [HomeModel]() {
        didSet {
            self.reloadTableView?()
        }
    }
    func callApi() {
        NetworkManager.request(urlString: "https://fakestoreapi.com/products", modelType: [HomeModel].self, httpMethod: .get) { response in
            switch response {
                case .success(let productList):
                    self.model = productList
                    print("Data fetching done \(productList.count)")
                   // print("Data fetching done: \(productList)")
                case .failure(let error):
                    print("error aa gya : \(error.localizedDescription)")
            }
        }
    }
    func getCellValue(at indexPath: IndexPath) -> HomeModel? {
        return model.indices.contains(indexPath.row) ? model[indexPath.row] : nil
    }
}
