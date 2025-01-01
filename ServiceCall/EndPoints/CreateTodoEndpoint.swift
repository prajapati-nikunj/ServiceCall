//
//  CreateTodoEndpoint.swift
//  ServiceCall
//
//  Created by Nikunj on 12/30/24.
//
import Foundation
// 📝 Struct representing the "Create Todo" endpoint
struct CreateTodoEndpoint: Endpoint {
    // 📦 The new Todo item to be created
    let newTodo: TodoElement?
    
    // 🏠 Base URL for the API
    var baseURL: URL {
        URL(string: "https://jsonplaceholder.typicode.com")! // 🌐 JSONPlaceholder API
    }
    
    // 🛤️ Path for the "Create Todo" endpoint
    var path: String {
        "/todos"
    }
    
    // 🔀 HTTP method used for the request
    var method: HTTPMethod {
        .post // 📤 POST method for creating new data
    }
    
    // 📝 Headers for the request
    var headers: [String: String]? {
        ["Content-Type": "application/json"] // 🛠️ Specifies JSON data format
    }
    
    // 📦 Parameters for the request
    var parameters: [String: Any]? {
        [
            "title": newTodo?.title ?? "",       // 🏷️ The title of the new Todo
            "completed": newTodo?.completed ?? false // ✅ The completion status of the new Todo
        ]
    }
}

