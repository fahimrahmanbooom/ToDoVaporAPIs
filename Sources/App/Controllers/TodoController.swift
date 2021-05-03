//
//  File.swift
//  
//
//  Created by Fahim Rahman on 5/4/21.
//

import Vapor
import Fluent

final class TodoController {
    
    // create todo
    func createTodo(_ req: Request) throws -> EventLoopFuture<TodoModel> {
        
        let todo = try req.content.decode(TodoModel.self)
        return todo.create(on: req.db).map { todo }
    }
    
    // get all todos
    func getTodos(_ req: Request) throws -> EventLoopFuture<[TodoModel]> {
        
        TodoModel.query(on: req.db).all()
    }
    
    // get todo by id
    func getTodoById(_ req: Request) throws -> EventLoopFuture<TodoModel> {
        
        TodoModel.find(req.parameters.get("todoID"), on: req.db)
            .unwrap(or: Abort(.notFound))
    }
    
    // update todo by id
    func updateTodoById(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
        
        let todo = try req.content.decode(TodoModel.self)
        
        return TodoModel.find(todo.id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap {
                $0.title = todo.title
                return $0.update(on: req.db).transform(to: .ok)
            }
    }
    
    
    // update todo completion status by id
    func updateTodoCompletionStatusById(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
        
        let todo = try req.content.decode(TodoModel.self)
        
        return TodoModel.find(todo.id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap {
                $0.completed = todo.completed
                return $0.update(on: req.db).transform(to: .ok)
            }
    }
    
    // delete todo by id
    func deleteTodoById(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
        
        TodoModel.find(req.parameters.get("todoID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
    
    // delete all todos
    func deleteTodos(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
        
        TodoModel.query(on: req.db)
            .delete()
            .transform(to: .ok)
    }
}
