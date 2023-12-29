//
//  File.swift
//  
//
//  Created by Adriana Torres on 12/28/23.
//

import Foundation
import Fluent

class CreateGroceryItemTableMigration: AsyncMigration {
    
    func prepare(on database: Database) async throws {
        try await database.schema("grocery_items")
            .id()
            .field("title", .string, .required)
            .create()
    }
    
    //Undo migration to change fields or fix something
    func revert(on database: Database) async throws {
        try await database.schema("grocery_items")
            .delete()
    }
}
