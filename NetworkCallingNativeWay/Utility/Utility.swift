//
//  Utility.swift
//  NetworkCallingNativeWay
//
//  Created by Shivanshu Verma on 21/05/23.
//

import Foundation
import UIKit

struct Utility {
    static let shared = Utility()
    private init() {}
    /// Reference of the Scene delegate
    /// - Returns: SceneDelegate
    var getSceneDelegateReference: SceneDelegate {
        UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
    }
}
