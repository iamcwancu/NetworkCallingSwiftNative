//
//  AppFlowConfigure.swift
//  NetworkCallingNativeWay
//
//  Created by Shivanshu Verma on 21/05/23.
//

import UIKit

final class AppFlowConfigure {
    static let shared = AppFlowConfigure()
    private init() {}
    private let sceneDelegate = Utility.shared.getSceneDelegateReference
    
    
    /// Make a `HomeViewController` as rootViewController
    func home() {
        /// create `HomeViewController` object
        let homeViewController = HomeViewController()
        /// create object of `UINavigationController` to adopt the navigation for `HomeViewController`
        let navigationController = UINavigationController(rootViewController: homeViewController)
        /// Hiding the `navigationBar` for the `HomeViewController`
        navigationController.navigationBar.isHidden = true
        navigationController.interactivePopGestureRecognizer?.isEnabled = false
        /// configuring the `navigationController` as `rootViewController`
        sceneDelegate.window?.rootViewController = navigationController
        sceneDelegate.window?.makeKeyAndVisible()
    }
}
