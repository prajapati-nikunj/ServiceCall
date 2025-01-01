//
//  NetworkManager.swift
//  ServiceCall
//
//  Created by Nikunj on 12/30/24.
//

import Foundation

// 🌐 Protocol for network management
protocol NetworkManaging {
    // 📥 Generic fetch method to fetch data from a given endpoint (for GET requests)
    func fetch<T: Decodable>(from endpoint: Endpoint) async throws -> T

    // 📤 Fetch method for operations that don't return data (for POST, PUT, DELETE, etc.)
    func fetch(from endpoint: Endpoint) async throws -> Void
}

// 🕸️ Singleton class for managing network requests
final class NetworkManager: NetworkManaging {
    // 🛠️ Shared instance for global access
    static let shared = NetworkManager()
    
    // 🌐 URLSession for handling network requests
    private let session: URLSession
    
    // 🔒 Private initializer to enforce singleton usage
    private init(session: URLSession = .shared) {
        self.session = session
    }
    
    // 📥 Fetch method for retrieving data (Decodable)
    func fetch<T: Decodable>(from endpoint: Endpoint) async throws -> T {
        // 📝 Create a URLRequest from the endpoint
        let request = try endpoint.urlRequest()
        
        // 🌐 Perform the network request and get the data and response
        let (data, response) = try await session.data(for: request)
        
        // ✅ Validate the HTTP response
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse // 🛑 Throw error if response is invalid
        }
        
        // 🛡️ Validate the response status code
        try validateResponse(httpResponse)
        
        // 🔄 Decode the response data into the expected model type
        do {
            let decoder = JSONDecoder() // 🛠️ JSON decoder for parsing data
            return try decoder.decode(T.self, from: data) // ✅ Decoding the data
        } catch {
            throw NetworkError.decodingFailed // 📉 Handle decoding failure
        }
    }
    
    // 📤 Fetch method for operations that don't return data (Void)
    func fetch(from endpoint: Endpoint) async throws {
        // 📝 Create a URLRequest from the endpoint
        let request = try endpoint.urlRequest()
        
        // 🌐 Perform the network request and get the data and response
        let (_, response) = try await session.data(for: request)
        
        // ✅ Validate the HTTP response
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse // 🛑 Throw error if response is invalid
        }
        
        // 🛡️ Validate the response status code
        try validateResponse(httpResponse)
    }
    
    // 🛡️ Helper method to validate HTTP response codes
    private func validateResponse(_ response: HTTPURLResponse) throws {
        switch response.statusCode {
        case 200...299:
            return // ✅ Success
        case 400...499:
            throw NetworkError.clientError(response.statusCode) // 📟 Client-side error
        case 500...599:
            throw NetworkError.serverError(response.statusCode) // 🖥️ Server-side error
        default:
            throw NetworkError.unknownError(response.statusCode) // ❓ Unknown error
        }
    }
}
