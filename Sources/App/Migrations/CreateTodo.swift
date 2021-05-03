//
//  CreateTodo.swift
//  
//
//  Created by Fahim Rahman on 5/3/21.
//

import Fluent

struct CreateTodo: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        
        database.schema("todos")
            .id()
            .field("title", .string, .required)
            .field("completed", .bool, .required, .custom("DEFAULT false"))
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("todos")
            .delete()
    }
}
