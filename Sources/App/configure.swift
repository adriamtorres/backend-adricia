import Vapor
import Fluent
import FluentPostgresDriver
import JWT

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    
    if let databaseURL = Environment.get("DATABASE_URL"), var postgresConfig = PostgresConfiguration(url: databaseURL) {
        postgresConfig.tlsConfiguration = .makeClientConfiguration()
        postgresConfig.tlsConfiguration?.certificateVerification = .none
        app.databases.use(.postgres(configuration: postgresConfig), as: .psql)
    } else {
        app.databases.use(.postgres(hostname: Environment.get("DB_HOST_NAME") ?? "localhost" , username: Environment.get("DB_USER_NAME") ?? "postgres", password: Environment.get("DB_PASSWORD") ?? "", database: Environment.get("DB_NAME") ?? "adriciadb"), as: .psql)
    }
    
    // register migrations
    app.migrations.add(CreateUsersTableMigration())
    app.migrations.add(CreateGroceryItemTableMigration())
    
    // command line
    // > swift run App migrate
    // > swift run App migrate --revert
    
    // register controllers
    try app.register(collection: UserController())
    try app.register(collection: GroceryController())
    
    app.jwt.signers.use(.hs256(key: Environment.get("JWT_SIGN_KEY") ?? "secretKey"))
    
    // register routes
    try routes(app)
}
