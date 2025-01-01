//
//  TodoListEndpoint.swift
//  ServiceCall
//
//  Created by Nikunj on 12/30/24.
//

import Foundation

// 📝 Struct representing the "Todo List" endpoint
struct TodoListEndpoint: Endpoint {
    // 🏠 Base URL for the API
    var baseURL: URL {
        URL(string: "https://jsonplaceholder.typicode.com")! // 🌐 JSONPlaceholder API
    }
    
    // 🛤️ Path for fetching the list of Todos
    var path: String {
        "/todos" // 🔗 The endpoint to retrieve all Todos
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
