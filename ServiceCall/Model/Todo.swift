//
//  Todo.swift
//  ServiceCall
//
//  Created by Nikunj on 12/30/24.
//

import Foundation

import Foundation

// MARK: - 🗂️ TodoElement
/// Represents a single Todo item retrieved from the API.
struct TodoElement: Codable, Identifiable { // ✔️ Conforms to Identifiable
    let userID, id: Int?      // 🆔 User and Todo ID
    var title: String?        // 🏷️ Title of the Todo item
    var completed: Bool?      // ✅ Completion status of the Todo item

    // 🗝️ Coding keys to map JSON keys to Swift property names
    enum CodingKeys: String, CodingKey {
        case userID = "userId" // 📋 Maps "userId" in JSON to `userID`
        case id, title, completed
    }
}

// 🗂️ Typealias for an array of Todo items
typealias Todo = [TodoElement]
