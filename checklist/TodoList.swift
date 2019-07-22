//
//  TodoList.swift
//  checklist
//
//  Created by Leah Yassky on 7/11/19.
//  Copyright © 2019 Leah Yassky. All rights reserved.
//

import Foundation

class TodoList{
    var todos: [ChecklistItem] = []
    
    init() {
//        let row0Item = ChecklistItem()
        
        
//        How to hardcode todoItems
    
//        row0Item.text = "Hello for now zzzz0"
//        row1Item.text = "Hello for now 1"
//        row2Item.text = "Hello for now 2"
//        row3Item.text = "Hello for now 3"
//        row4Item.text = "Hello for now 4"
//
//        todos.append(row0Item)
//        todos.append(row1Item)
//        todos.append(row2Item)
//        todos.append(row3Item)
//        todos.append(row4Item)
        
    }
    
    
    func newTodo() -> ChecklistItem {
        let item = ChecklistItem()
        item.text = randomTitle()
        item.checked = true
        todos.append(item)
        return item
    }
    
    private func randomTitle() -> String {
        var titles = ["new task", "Help", "Valium", "generate String", "thinking"]
        let randomNumber = Int.random(in: 0 ... titles.count - 1 )
        return titles[randomNumber]
    }
}
