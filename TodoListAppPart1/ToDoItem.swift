// Authors
// Name: Hisahm Abu Sanimeh
// StudentID: 301289364
// Name: Fernando Quezada
// StudentID: 301286477

// Date: 27-Nov-2022

// App description:
// Assignment 5 – Todo List App - Part 2 - Logic for Data Persistence

import Foundation

struct ToDoItem: Codable {
    var isSelected: Bool?
    var name: String
    var dueDate: Date
    var notes: String
    var isCompleted: Bool?
    var statusTask: Int?
    var hasDueDate: Bool  // It's a switch
    var notificationID: String?
}
