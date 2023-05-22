//
//  HomeViewModel.swift
//  NetworkCallingNativeWay
//
//  Created by Shivanshu Verma on 21/05/23.
//

import Foundation

class HomeViewModel {
    func callApi() {
        NetworkManager.request(urlString: "https://fakestoreapi.com/products", modelType: [ProductModel].self, httpMethod: .get) { response in
            switch response {
                case .success(let productList):
                    print("Data is: \(productList)")
                case .failure(let error):
                    print("error aa gya : \(error.localizedDescription)")
            }
        }
    }
}
