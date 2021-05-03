import Vapor
import Fluent
import FluentPostgresDriver

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // register routes
    
    app.databases.use(.postgres(hostname: "localhost",
                                username: "postgres",
                                password: "",
                                database: "tododb"),
                                as: .psql)
    
    app.migrations.add(CreateTodo())
    
    try app.autoMigrate().wait() // enable auto migrate
    
    try routes(app)
}
