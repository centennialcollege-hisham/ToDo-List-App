//
//  ToDoItem.swift
//  TodoListAppPart1
//
//  Created by Victor Quezada on 2022-11-25.
//

import Foundation

struct ToDoItem: Codable {
    var name: String
    var date: Date
    var notes: String
    var statusTask: Int
    var reminderSet: Bool  // It's a switch
    var notificationID: String?
}
