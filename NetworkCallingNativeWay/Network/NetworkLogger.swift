//
//  NetworkLogger.swift
//  NetworkCallingNativeWay
//
//  Created by Shivanshu Verma on 10/06/23.
//

import Foundation
struct NetworkLogger {
    static func header(dict: [AnyHashable : Any]) {
        /// Convert the dictionary to JSON data
        if let jsonData = try? JSONSerialization.data(withJSONObject: dict,
                                                      options: [.prettyPrinted, .sortedKeys]) {
            /// Convert the JSON data to a string
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                /// Print the JSON string
                print(jsonString)
            }
        }
    }
}
