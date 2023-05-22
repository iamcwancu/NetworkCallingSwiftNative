//
//  ParameterEncoder.swift
//  NetworkCallingNativeWay
//
//  Created by Shivanshu Verma on 21/05/23.
//

import Foundation
public protocol ParameterEncoding {
    func encode(urlRequest: inout URLRequest, with parameters: HTTPParameters) throws
}
/// Encode the parameters for the query string to be set as or appended to any existing URL query string
public struct URLParameterEncoder: ParameterEncoding {
    public func encode(urlRequest: inout URLRequest, with parameters: HTTPParameters) throws {
        /// if `urlRequest.url` is nil throw the error otherwise get the url
        guard let url = urlRequest.url else { throw NetworkError.missingURL }
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
           let parameter = parameters, parameter.isEmpty == false {
            /// create an array of `URLQueryItem` objects by mapping each key-value pair to a `URLQueryItem`.
            let queryItems = parameter.map { (key, value) in
                URLQueryItem(name: key, value: "\(value)")
            }
            /// assigning the `URLQueryItem` object into the `urlComponents.queryItems`
            urlComponents.queryItems = queryItems
            /// assigning the final URL to the `urlRequest.url` from the `urlComponents.url`
            urlRequest.url = urlComponents.url
        }
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
    }
}
///  Encode the parameters as JSON representable and set the body of the `URLRequest`.
public struct JSONParameterEncoder: ParameterEncoding {
    public func encode(urlRequest: inout URLRequest, with parameters: HTTPParameters) throws {
        /// if `HTTPParameters` nil throws the error
        guard let parameter = parameters else { throw NetworkError.parametersNil }
        do {
            /// Uses `JSONSerialization` to create a JSON representation of the parameters object,
            let data = try JSONSerialization.data(withJSONObject: parameter, options: .prettyPrinted)
            /// If HTTP HeaderField `Content-Type` is nil
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                /// Add the `Content-Type` HTTP header field of an encoded request is set to `application/json`.
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            /// set the body of the request
            urlRequest.httpBody = data
        } catch {
            /// if getting error while encoding into `JSONSerialization` throw the same
            throw NetworkError.encodingFailed(error)
        }
    }
}
