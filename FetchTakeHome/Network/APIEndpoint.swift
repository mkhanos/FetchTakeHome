//
//  APIEndpoint.swift
//  FetchTakeHome
//
//  Created by Momo Khan on 5/30/25.
//

import Foundation

protocol APIEndpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var mockFile: String { get }
}

extension APIEndpoint {
    var baseURL: String {
        return "d3jbb8n5wk0qxi.cloudfront.net"
    }
    
    func buildRequest() throws -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = baseURL
        urlComponents.path = path
        
        guard let url = urlComponents.url else {
            throw NetworkError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        return request
    }
}
