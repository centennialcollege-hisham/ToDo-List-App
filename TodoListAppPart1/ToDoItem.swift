//
//  ToDoItem.swift
//  TodoListAppPart1
//
//  Created by Victor Quezada on 2022-11-25.
//

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
