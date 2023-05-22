//
//  HTTPMethod.swift
//  NetworkCallingNativeWay
//
//  Created by Shivanshu Verma on 21/05/23.
//

import Foundation
public typealias HTTPParameters = [String: Any]?
public typealias HTTPHeaders = [String: Any]

public enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case delete  = "DELETE"
    /// return string of `rawValue` as uppercased
    var value: String {
        self.rawValue.uppercased()
    }
}
