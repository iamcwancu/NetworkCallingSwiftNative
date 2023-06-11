//
//  URLSession+Addition.swift
//  NetworkCallingNativeWay
//
//  Created by Shivanshu Verma on 11/06/23.
//

import Foundation

extension URLSession {
    /// Custom URLSessionConfiguration setting added
    /// - Returns: URLSession
    ///
    /// When a request is made with a `URLSession`, the cache policy of the `URLRequest` is checked first. If the cache policy is set in the `URLRequest`, it will be used for that specific request. If the cache policy is not set in the URLRequest, then the cache policy from the `URLSessionConfiguration` will be used for that request.
    /// Other words, ``if you set the cache policy in both places, the cache policy specified in the "URLRequest" will override the one set in the "URLSessionConfiguration" for that particular request``.
    public static func customConfiguration() -> URLSession {
        /// Create a URLSessionConfiguration object
        let configuration = URLSessionConfiguration.default
        /// Set the cache policy
        /// requestCachePolicy:  if `Internet` Connection is `available` than `reloadRevalidatingCacheData` other wise `returnCacheDataDontLoad`
        configuration.requestCachePolicy = Connection.isAvailable ? .reloadRevalidatingCacheData: .returnCacheDataDontLoad
        /// Set the cache storage policy
        let memoryCapacity = 100 * 1024 * 1024 // 100 MB
        let diskCapacity = 1000 * 1024 * 1024 // 1000 MB ( 1 GB Approximately)
        configuration.urlCache?.memoryCapacity = memoryCapacity
        configuration.urlCache?.diskCapacity   = diskCapacity
        /*
        /// Available from `iOS 13.0`
        configuration.urlCache = URLCache(memoryCapacity: 100 * 1024 * 1024,
                                          diskCapacity: 500 * 1024 * 1024)
         */
        /// set the `timeoutIntervalForRequest` for every request
        /// ``Note :` If that setting the `timeoutInterval` in the `URLRequest` overrides the `timeoutIntervalForRequest` property of the `URLSessionConfiguration` for that specific request.``
        configuration.timeoutIntervalForRequest = 60
        /// Return a `URLSession` with the custom configuration
        return URLSession(configuration: configuration)
    }
}
