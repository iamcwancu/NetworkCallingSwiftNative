//
//  UrlRequestConfigure.swift
//  NetworkCallingNativeWay
//
//  Created by Shivanshu Verma on 21/05/23.
//

import Foundation
struct UrlRequest {
    static func configure(url: String,
                          parameters: HTTPParameters,
                          headers: HTTPHeaders,
                          method: HTTPMethod,
                          encoding: URLEncoder ) throws -> URLRequest {
        guard let url = URL(string: url) else { fatalError("Error while unwrapping URL") }
        // var urlRequest = URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.value
        try configureParametersAndHeaders(&urlRequest, parameters, headers, encoding)
        return urlRequest
    }
    /// Configure the parameters and headers for the request
    private static func configureParametersAndHeaders(_ request: inout URLRequest,
                                                      _ parameters: HTTPParameters,
                                                      _ headers: HTTPHeaders,
                                                      _ encoding: URLEncoder) throws {
        do {
            if let parameter = parameters {
                try encoding.encode(urlRequest: &request, with: parameter)
                try encoding.configureHeaders(for: &request, with: headers)
            }
        } catch {
            throw error
        }
    }
}
