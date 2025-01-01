//
//  TodoViewModel.swift
//  ServiceCall
//
//  Created by Nikunj on 12/30/24.
//
import SwiftUI
import Foundation

// MARK: - 🧠 ViewModel for Todo Management
/// Handles the fetching, creating, and managing of Todo items.
@MainActor
class TodoViewModel: ObservableObject {
    // 🗂️ Published properties to track Todos and errors
    @Published var todos: [TodoElement] = [] // 📝 List of Todo items
    @Published var error: NetworkError? // ⚠️ Network error (if any)
    
    // 🌐 Reference to the network manager
    private let networkManager: NetworkManaging
    
    // 🛠️ Initialize the ViewModel with a network manager
    init(networkManager: NetworkManaging = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    // 🔄 Sort Todos by ID in descending order
    private func sortTodos() {
        todos.sort { ($0.id ?? 0) > ($1.id ?? 0) }
    }
    
    // 🔄 Fetch all Todos
    func fetchTodos() async {
        do {
            // 🌐 Fetch data using the TodoListEndpoint
            self.todos = try await networkManager.fetch(from: TodoListEndpoint())
            sortTodos() // 🔄 Sort the Todos after fetching
        } catch let error as NetworkError {
            // ⚠️ Handle specific network errors
            self.error = error
        } catch {
            // ❓ Handle any other unknown errors
            self.error = .unknownError(0)
        }
    }
    
    // 🔍 Fetch a single Todo by ID
    func fetchSingleTodo(id: Int) async {
        do {
            // 🌐 Fetch data using the SingleTodoEndpoint
            let todo: TodoElement = try await networkManager.fetch(from: SingleTodoEndpoint(id: id))
            self.todos = [todo] // 📦 Replace the todos list with the single Todo
            sortTodos() // 🔄 Sort the Todos after adding a new one
        } catch let error as NetworkError {
            // ⚠️ Handle specific network errors
            self.error = error
        } catch {
            // ❓ Handle any other unknown errors
            self.error = .unknownError(0)
        }
    }
    
    // 📝 Create a new Todo
    func createTodo(title: String) async {
        // 🆕 Define a new Todo item
        let newTodo = TodoElement(userID: nil, id: nil, title: title, completed: false)
        
        do {
            // 🌐 Send a request using the CreateTodoEndpoint
            let createdTodo: TodoElement = try await networkManager.fetch(from: CreateTodoEndpoint(newTodo: newTodo))
            self.todos.append(createdTodo) // 📥 Append the newly created Todo
            sortTodos() // 🔄 Sort the Todos after adding a new one
        } catch let error as NetworkError {
            // ⚠️ Handle specific network errors
            self.error = error
        } catch {
            // ❓ Handle any other unknown errors
            self.error = .unknownError(0)
        }
    }
    // 🔄 Update an existing Todo (toggle completion status)
    func updateTodo(todo: TodoElement) async {
        var updatedTodo = todo
        updatedTodo.completed?.toggle() // 🔄 Toggle the completion status
        
        do {
            // 🌐 Send update request using the UpdateTodoEndpoint
            let updateElement: TodoElement = try await networkManager.fetch(from: UpdateTodoEndpoint(todo: updatedTodo))
            // 📦 Update the local list of Todos after successful update
            if let index = todos.firstIndex(where: { $0.id == todo.id }) {
                todos[index] = updateElement
                sortTodos() // 🔄 Sort the Todos after updating
            }
        } catch let error as NetworkError {
            // ⚠️ Handle specific network errors
            self.error = error
        } catch {
            // ❓ Handle any other unknown errors
            self.error = .unknownError(0)
        }
    }
    
    // ➖ Delete a Todo by ID
    func deleteTodo(id: Int) async {
        do {
            // 🌐 Send a delete request using the DeleteTodoEndpoint
            let _ = try await networkManager.fetch(from: DeleteTodoEndpoint(id: id))
            
            // 📦 Remove the Todo from the local list after successful deletion
            if let index = todos.firstIndex(where: { $0.id == id }) {
                todos.remove(at: index) // ➖ Remove Todo from list
                sortTodos() // 🔄 Sort the Todos after deleting
            }
        } catch let error as NetworkError {
            // ⚠️ Handle specific network errors
            self.error = error
        } catch {
            // ❓ Handle any other unknown errors
            self.error = .unknownError(0)
        }
    }
}
