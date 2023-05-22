//
//  URLEncoder.swift
//  NetworkCallingNativeWay
//
//  Created by Shivanshu Verma on 21/05/23.
//

import Foundation

public enum URLEncoder: ParameterEncoding {
    case urlEncoding
    case paramEncoding
    /// Encode the URLRequest based on the case selection
    /// - Parameters:
    ///   - urlRequest: URLRequest
    ///   - parameters: HTTPParameters
    public func encode(urlRequest: inout URLRequest, with parameters: HTTPParameters) throws {
        do {
            switch self {
                case .urlEncoding:
                    guard let parameter = parameters else { return }
                    try URLParameterEncoder().encode(urlRequest: &urlRequest, with: parameter)
                case .paramEncoding:
                    guard let parameter = parameters else { return }
                    try JSONParameterEncoder().encode(urlRequest: &urlRequest, with: parameter)
            }
        } catch {
            throw error
        }
    }
    /// Set the  http `Headers` of the URLRequest
    public func configureHeaders(for urlRequest: inout URLRequest, with headers: HTTPHeaders) throws {
        headers.forEach { (key, value) in
            urlRequest.setValue("\(value)", forHTTPHeaderField: key)
        }
    }
}
