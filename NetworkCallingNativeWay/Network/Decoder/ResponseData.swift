//
//  ResponseData.swift
//  NetworkCallingNativeWay
//
//  Created by Shivanshu Verma on 22/05/23.
//

import Foundation

/// Decode the data as model type
struct ResponseData {
    static func  decode<T>(_ modelType: T.Type, data: Data) -> Result<T, NetworkError> where T: Decodable {
        do {
            let modelResponse = try JSONDecoder().decode(modelType.self, from: data)
            return .success(modelResponse)
        } catch {
            return .failure(NetworkError.error(error))
        }
    }
}
