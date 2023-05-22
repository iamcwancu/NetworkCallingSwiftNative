//
//  HomeViewController.swift
//  NetworkCallingNativeWay
//
//  Created by Shivanshu Verma on 21/05/23.
//

import UIKit

class HomeViewController: UIViewController {
    private let homeVM = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemPink.withAlphaComponent(0.8)
        homeVM.callApi()
    }
}
