//
//  NetworkError.swift
//  NetworkCallingNativeWay
//
//  Created by Shivanshu Verma on 21/05/23.
//

import Foundation
public enum NetworkError: Error {
    case missingURL
    case parametersNil
    case encodingFailed(_ error: Error)
    case errorString(_ error: String)
    case error(_ error: Error)
    case unwrapping
    case noData
    case failed
    case badRequest
    case unauthorized
    case preconditionFailed
    case paymentRequired
    case forbidden
    case notFound//
    case internalServerError
    case serverSideError
    
    var localizedDescription: String {
        switch self {
            case .missingURL:
                return "URL request to encode was missing a URL"
            case .parametersNil:
                return "Parameters are nil"
            case .encodingFailed(let error):
                return "JSON could not be encoded because of error:\n \(error.localizedDescription)"
            case .errorString(let error):
                return error
            case .error(let error):
                return error.localizedDescription
            case .unwrapping:
                return "Unable to unwrap the data"
            case .noData:
                return "Data is nil"
            case .failed:
                return "Network request failed"
            case .badRequest:
                return "Bad request"
            case .unauthorized:
                return "Unauthorized"
            case .preconditionFailed:
                return "Precondition failed"
            case .paymentRequired:
                return "Payment required"
            case .forbidden:
                return "Forbidden error"
            case .notFound:
                return "Not found"
            case .internalServerError:
                return "Internal server error"
            case .serverSideError:
                return "Server side error"
        }
    }
}
