//
//  ItemModel.swift
//  ExpenseTracker
//
//  Created by  aleksandr on 25.05.25.
//  Copyright © 2025 Alfian Losari. All rights reserved.
//

import Foundation

// Immutable Struct has only 'let' constants
struct ItemModel: Identifiable, Codable {
    let id: String
    let title: String
    let isCompleted: Bool
    
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
    
    func updateCompletion() -> ItemModel {
        return ItemModel(id: id, title: title, isCompleted: !isCompleted)
    }
    
}

//#Preview {
//    ItemModel()
//}
