//
//  NetworkError.swift
//  ServiceCall
//
//  Created by Nikunj on 12/30/24.
//

import Foundation

// ⚠️ Enum to define network-related errors
enum NetworkError: Error {
    // 🛑 Error for invalid or unexpected responses
    case invalidResponse
    
    // 📉 Error when decoding response data fails
    case decodingFailed
    
    // 📟 Error representing client-side issues (4xx HTTP status codes)
    case clientError(Int)
    
    // 🖥️ Error representing server-side issues (5xx HTTP status codes)
    case serverError(Int)
    
    // ❓ Error for unclassified or unexpected issues
    case unknownError(Int)
}

// 🌟 Extension to provide localized error descriptions
extension NetworkError: LocalizedError {
    // 📝 Custom error messages for each case
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            // 🛑 Message for invalid server responses
            return "Invalid response received from the server."
        case .decodingFailed:
            // 📉 Message for decoding issues
            return "Failed to decode the response data."
        case .clientError(let statusCode):
            // 📟 Message for client-side errors
            return "Client error occurred. Status code: \(statusCode)"
        case .serverError(let statusCode):
            // 🖥️ Message for server-side errors
            return "Server error occurred. Status code: \(statusCode)"
        case .unknownError(let statusCode):
            // ❓ Message for unknown errors
            return "An unknown error occurred. Status code: \(statusCode)"
        }
    }
}
