//
//  Endpoint.swift
//  ServiceCall
//
//  Created by Nikunj on 12/30/24.
//

import Foundation
/// 🌐 Protocol defining an API Endpoint
protocol Endpoint {
    // 🏠 Base URL for the API
    var baseURL: URL { get }
    
    // 🛤️ Path for the specific endpoint
    var path: String { get }
    
    // 🔀 HTTP method (GET, POST, etc.)
    var method: HTTPMethod { get }
    
    // 📝 Headers for the request (optional)
    var headers: [String: String]? { get }
    
    // 📦 Parameters for the request (optional)
    var parameters: [String: Any]? { get }
}

// 🛠️ Default implementation for the `Endpoint` protocol
extension Endpoint {
    // 📨 Function to create a `URLRequest` from the endpoint properties
    func urlRequest() throws -> URLRequest {
        // 🔗 Construct the full URL by appending the path to the base URL
        let url = baseURL.appendingPathComponent(path)
        
        // 🛠️ Create a URLRequest with the constructed URL
        var request = URLRequest(url: url)
        
        // 🔀 Set the HTTP method
        request.httpMethod = method.rawValue
        
        // 📝 Add headers to the request if available
        request.allHTTPHeaderFields = headers
        
        // ⚙️ Handle parameters
        if let parameters = parameters {
            if method == .get {
                // 🧩 For GET requests, add parameters as query items to the URL
                var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
                components?.queryItems = parameters.map {
                    URLQueryItem(name: $0.key, value: "\($0.value)")
                }
                // 🔗 Update the URL in the request
                request.url = components?.url
            } else {
                // 📝 For other HTTP methods, encode parameters as JSON in the body
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
            }
        }
        
        // 🚀 Return the constructed URLRequest
        return request
    }
}
