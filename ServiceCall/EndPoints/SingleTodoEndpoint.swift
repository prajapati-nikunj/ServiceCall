//
//  SingleTodoEndpoint.swift
//  ServiceCall
//
//  Created by Nikunj on 12/30/24.
//
import Foundation

// 📝 Struct representing the "Single Todo" endpoint
struct SingleTodoEndpoint: Endpoint {
    // 🆔 ID of the Todo item to fetch
    let id: Int
    
    // 🏠 Base URL for the API
    var baseURL: URL {
        URL(string: "https://jsonplaceholder.typicode.com")! // 🌐 JSONPlaceholder API
    }
    
    // 🛤️ Path for fetching a specific Todo item
    var path: String {
        "/todos/\(id)" // 🔗 Append the Todo ID to the endpoint path
    }
    
    // 🔀 HTTP method used for the request
    var method: HTTPMethod {
        .get // 📥 GET method for retrieving data
    }
    
    // 📝 Headers for the request
    var headers: [String: String]? {
        ["Content-Type": "application/json"] // 🛠️ Specifies JSON data format
    }
    
    // ❌ No parameters needed for this request
    var parameters: [String: Any]? {
        nil
    }
}

