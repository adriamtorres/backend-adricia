//
//  CreateUsersTableMigration.swift
//
//
//  Created by Adriana Torres on 12/15/23.
//

import Foundation
import Fluent

struct CreateUsersTableMigration: AsyncMigration {
    
    func prepare(on database: Database) async throws {
        try await database.schema("users")
            .id()
            .field("username", .string, .required).unique(on: "username")
            .field("password", .string, .required)
            .create()
    }
    
    //Undo migration to change fields or fix something
    func revert(on database: Database) async throws {
        try await database.schema("users")
            .delete()
    }
}
