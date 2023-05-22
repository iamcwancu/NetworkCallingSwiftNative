//
//  ResponseHandlers.swift
//  NetworkCallingNativeWay
//
//  Created by Shivanshu Verma on 21/05/23.
//

import Foundation

struct HttpNetworkResponse {
    static func handler(_ response : HTTPURLResponse) -> (Result<[AnyHashable : Any], NetworkError>) {
        switch response.statusCode {
            case 200...399:     return .success(response.allHeaderFields)
            case 400:           return .failure(.badRequest)
            case 401:           return .failure(.unauthorized)
            case 402:           return .failure(.paymentRequired)
            case 403:           return .failure(.forbidden)
            case 404:           return .failure(.notFound)
            case 405...411:     return .failure(.badRequest)
            case 412:           return .failure(.preconditionFailed)
            case 413...499:     return .failure(.badRequest)
            case 500:           return .failure(.internalServerError)
            case 501...599:     return .failure(.serverSideError)
            default:            return .failure(.failed)
        }
    }
}
/// Unwrap the dataTask completion data
struct Unwrapped {
    static func response(_ data: Data?,
                         _ response: URLResponse?,
                         _ error: Error?) -> (Result<(Data, HTTPURLResponse), NetworkError>) {
        /// if response error is not nil then
        /// return with `.failure` case
        if let error = error {
            return .failure(.error(error))
        }
        guard let data = data else {
            return .failure(.noData)
        }
        guard let httpResponse = response as? HTTPURLResponse else {
            return .failure(.errorString("Response is not an HTTPURLResponse"))
        }
        return .success((data, httpResponse))
    }
}
