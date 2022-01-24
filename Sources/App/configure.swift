import Fluent
import FluentPostgresDriver
import Vapor

public func configure(_ app: Application) throws {

    
    app.databases.use(.postgres(hostname: "localhost", username: "postgres", password: "", database: "vapordb"), as: .psql)

    app.migrations.add(CreateMovie())

    try routes(app)
}
