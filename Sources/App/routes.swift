import Vapor

func routes(_ app: Application) throws {
    
    let todoController = TodoController()
    
    // hit ip with port and check server is running or not
    app.get { req in
        return "Server is running... :D"
    }
    
    // get all todos
    app.get("todos", "getAll", use: todoController.getTodos)
    
    // create a new todo
    app.post("todo", "create", use: todoController.createTodo)
    
    // get a todo by id
    app.get("todo", ":todoID", use: todoController.getTodoById)
    
    // update a todo by id
    app.put("todo", "update", use: todoController.updateTodoById)
    
    // update completion status by id
    app.put("todo", "completion", use: todoController.updateTodoCompletionStatusById)
    
    // delete a todo by id
    app.delete("todo", ":todoID", use: todoController.deleteTodoById)
    
    // delete all todos
    app.delete("todos", "deleteAll", use: todoController.deleteTodos)
}
