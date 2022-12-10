//
//  ToDoItem.swift
//  todo
//
//  Created by Victor Quezada on 2022-11-27.
//

import Foundation

// Model

struct TodoItem: Codable {
    var title : String
    var date : String
    var desc : String
    var status : Int
    var reminderSet: Bool
    var notificationID: String?
}

//struct ToDoItem: Codable {
//    var name: String
//    var date: Date
//    var notes: String
//    var reminderSet: Bool
//    var notificationID: String?
//}
