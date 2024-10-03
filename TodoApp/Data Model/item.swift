//
//  item.swift
//  TodoApp
//
//  Created by Hussein Reda on 29/09/2024.
//

import Foundation

class Item: Codable{
    var title: String = ""
    var done: Bool = false
    
    init(title: String, done: Bool) {
        self.title = title
        self.done = done
    }
}
