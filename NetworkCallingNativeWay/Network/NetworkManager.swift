//
//  NetworkManager.swift
//  NetworkCallingNativeWay
//
//  Created by Shivanshu Verma on 21/05/23.
//

import Foundation
typealias completion<T> = (Result<T, NetworkError>) -> Void
struct NetworkManager {
    static func request<T>(urlString: String,
                           modelType: T.Type,
                           httpMethod: HTTPMethod,
                           parameter: HTTPParameters = [:],
                           header: HTTPHeaders = [:],
                           urlEncoder: URLEncoder = .urlEncoding,
                           completionHandler: @escaping completion<T>) where T: Codable {
        let urlSession = URLSession.customConfiguration()
        do {
            // MARK: - Url request configure's -
            let urlRequest = try UrlRequest.configure(url: urlString,
                                                                parameters: parameter,
                                                                headers: header,
                                                                method: httpMethod,
                                                                encoding: urlEncoder)
            urlSession.dataTask(with: urlRequest) { data, response, error in
                // MARK: - Unwrapped response all data -
                switch Unwrapped.response(data, response, error) {
                        /// if `unwrapped` return success
                    case .success(let (data, response)):
                        // MARK: - HTTP network response handler -
                        switch HttpNetworkResponse.handler(response) {
                                /// `HttpNetworkResponse` return success
                            case .success(let allHeaders):
                                NetworkLogger.header(dict: allHeaders)
                                /// when `HttpNetworkResponse` return the success
                                /// then decode the `data` as modelType
                                // MARK: - Response `Data` decoding -
                                switch ResponseData.decode(modelType.self, data: data) {
                                    case .success(let modelData):
                                        /// if decoding  `success` return the `modelType data`
                                        DispatchQueue.main.async {
                                            completionHandler(.success(modelData))
                                        }
                                    case .failure(let decodingFail):
                                        /// if decoding `fail` return the `failure reason`
                                        DispatchQueue.main.async {
                                            completionHandler(.failure(decodingFail))
                                        }
                                }
                                /// `HttpNetworkResponse` return failure
                            case .failure(let httpResponseFailure):
                                switch httpResponseFailure {
                                    case .preconditionFailed:
                                        DispatchQueue.main.async {
                                            completionHandler(.failure(.preconditionFailed))
                                        }
                                    case .unauthorized:
                                        DispatchQueue.main.async {
                                            completionHandler(.failure(.unauthorized))
                                        }
                                    default:
                                        DispatchQueue.main.async {
                                            completionHandler(.failure(httpResponseFailure))
                                        }
                                }
                        }
                        /// if `unwrapped` return failure
                    case .failure(let error):
                        DispatchQueue.main.async {
                            completionHandler(.failure(error))
                        }
                }
            }.resume()
            
        } catch {
            ///  When`Url request configure's` failed then this catch block will be execute
            DispatchQueue.main.async {
                completionHandler(.failure(NetworkError.error(error)))
            }
        }
    }
}
