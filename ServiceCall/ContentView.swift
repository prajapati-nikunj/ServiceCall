//
//  ContentView.swift
//  ServiceCall
//
//  Created by Nikunj on 12/30/24.
//

import SwiftUI

// MARK: - 🖥️ ContentView
/// Main view to display the list of Todos, and handle Create, Update, List (GET), and Delete operations.
struct ContentView: View {
    // 🧠 StateObject to manage the TodoViewModel
    @StateObject private var viewModel = TodoViewModel()
    
    // 📝 State to handle new Todo title input
    @State private var newTodoTitle: String = ""
    
    // 📝 State to handle editing an existing Todo
    @State private var editingTodo: TodoElement? = nil
    
    var body: some View {
        // 🚀 Navigation view to structure the app
        NavigationView {
            VStack {
                // 📝 TextField for adding or editing a Todo
                TextField("Enter Todo title", text: $newTodoTitle) // 🏷️ Input for Todo title
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle()) // ✨ Styling the text field
                
                // ➕ Button to create a new Todo
                Button("Create Todo") {
                    Task {
                        await viewModel.createTodo(title: newTodoTitle) // 🆕 Create Todo using ViewModel
                        newTodoTitle = "" // 🧹 Reset input field after creation
                    }
                }
                .padding()
                .disabled(newTodoTitle.isEmpty) // 🔒 Disable if input is empty
                
                // 📝 Display a list of Todos
                List {
                    ForEach(viewModel.todos) { todo in
                        HStack {
                            Text(todo.title ?? "Untitled") // 🏷️ Display Todo title
                            Spacer()
                            if todo.completed == true {
                                Image(systemName: "checkmark") // ✅ Show checkmark for completed Todos
                            }
                        }
                        .onTapGesture {
                            editingTodo = todo // 🖊️ Set the Todo for editing
                            newTodoTitle = todo.title ?? "" // 📝 Pre-fill the title for editing
                        }
                        .swipeActions {
                            // ➖ Swipe to delete a Todo
                            Button(role: .destructive) {
                                Task {
                                    await viewModel.deleteTodo(id: todo.id ?? 0) // 🗑️ Delete Todo
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
                
                // 🔄 Update Todo Button (Visible when editing)
                if let editingTodo = editingTodo {
                    Button("Update Todo") {
                        Task {
                            let updateTodo = TodoElement(userID: editingTodo.id ?? 0, id: editingTodo.id ?? 0, title: newTodoTitle)
                            await viewModel.updateTodo(todo: updateTodo)
                             // 🔄 Update Todo title
                            self.editingTodo = nil // 🧹 Reset editing state
                            newTodoTitle = "" // 🧹 Reset input field after update
                        }
                    }
                    .padding()
                    .disabled(newTodoTitle.isEmpty) // 🔒 Disable if input is empty
                }
            }
            .navigationTitle("Todos") // 🗂️ Navigation bar title
        }
        // 🌐 Fetch todos when the view appears
        .task {
            await viewModel.fetchTodos() // 🔄 Fetch the list of Todos
        }
    }
}

// 🖼️ Preview for SwiftUI canvas
#Preview {
    ContentView()
}
