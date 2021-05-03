//
//  todoModel.swift
//  
//
//  Created by Fahim Rahman on 5/4/21.
//

import Vapor
import Fluent

final class TodoModel: Model, Content {
    
    static let schema: String = "todos"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "completed")
    var completed: Bool
    
    init() {}
    
    init(id: UUID? = nil, title: String, completed: Bool = false) {
        
        self.id = id
        self.title = title
        self.completed = completed
    }
}
