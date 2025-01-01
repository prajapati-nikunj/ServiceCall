//
//  DeleteTodoEndpoint.swift
//  ServiceCall
//
//  Created by Nikunj on 12/30/24.
//

import Foundation

// MARK: - 🗑️ Endpoint for Deleting a Todo
struct DeleteTodoEndpoint: Endpoint {
    let id: Int // 📝 ID of the Todo to be deleted
    
    var baseURL: URL {
        URL(string: "https://jsonplaceholder.typicode.com")! // 🌍 Base URL for the API
    }
    
    var path: String {
        "/todos/\(id)" // 📍 Endpoint path with the Todo's ID
    }
    
    var method: HTTPMethod {
        .delete // ❌ Method for deleting the Todo
    }
    
    var headers: [String : String]? {
        ["Content-Type": "application/json"] // 🧾 Content type for JSON request
    }
    
    var parameters: [String : Any]? {
        nil // ❌ No parameters are required for DELETE
    }
}
