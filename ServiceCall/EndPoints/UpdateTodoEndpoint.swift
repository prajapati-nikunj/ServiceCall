//
//  UpdateTodoEndpoint.swift
//  ServiceCall
//
//  Created by Nikunj on 12/30/24.
//

import Foundation

// MARK: - 🛠️ Endpoint for Updating a Todo
struct UpdateTodoEndpoint: Endpoint {
    let todo: TodoElement // 📝 Todo item to be updated
    
    var baseURL: URL {
        URL(string: "https://jsonplaceholder.typicode.com")! // 🌍 Base URL for the API
    }
    
    var path: String {
        "/todos/\(todo.id ?? 0)" // 📍 Endpoint path with the Todo's ID
    }
    
    var method: HTTPMethod {
        .put // 🔄 Method for updating the Todo
    }
    
    var headers: [String : String]? {
        ["Content-Type": "application/json"] // 🧾 Content type for JSON request
    }
    
    var parameters: [String : Any]? {
        // 📝 Parameters to update the Todo
        [
            "title": todo.title ?? "", // 🏷️ Update the title
            "completed": todo.completed ?? false // ✅ Update the completion status
        ]
    }
}
