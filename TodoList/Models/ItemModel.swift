//
//  ItemModel.swift
//  TodoList
//
//  Created by Andy Bennett on 11/13/24.
//

import Foundation

// Immutable struct
struct ItemModel: Identifiable, Codable {
    let id: String
    let title: String
    let isCompleted: Bool
    
    // id: String = UUID().uuidString, this acts like a default value if nothing is set
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
    
    func updateCompletion() -> ItemModel {
        return ItemModel(id: id, title: title, isCompleted: !isCompleted)
    }
}
