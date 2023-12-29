//
//  File.swift
//
//
//  Created by Adriana Torres on 12/28/23.
//

import Foundation
import Vapor
import Fluent
import AdriciaSharedDTO

class GroceryController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        // POST
        let api = routes.grouped("api")
        
        api.get("grocery-items", use: getGroceryItems)
        api.post("grocery-items", use: saveGroceryItem)
        api.delete("grocery-items", ":groceryItemId", use: deleteGroceryItems)
    }
    
    func getGroceryItems(req: Request) async throws -> [GroceryItemResponseDTO] {
        return try await GroceryItem.query(on: req.db)
            .all()
            .compactMap(GroceryItemResponseDTO.init)
    }
    
    func saveGroceryItem(req: Request) async throws -> GroceryItemResponseDTO {
        // DTO request | response
        let groceryItemRequestDTO = try req.content.decode(GroceryItemRequestDTO.self)
        
        let groceryItem = GroceryItem(title: groceryItemRequestDTO.title)
        
        try await groceryItem.save(on: req.db)
        
        guard let groceryItemResponseDTO = GroceryItemResponseDTO(groceryItem) else {
            throw Abort(.internalServerError)
        }
        
        return groceryItemResponseDTO
    }
    
    func deleteGroceryItems(req: Request) async throws -> GroceryItemResponseDTO {
        guard let groceryItemId = req.parameters.get("groceryItemId", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        
        guard let groceryItem = try await GroceryItem.query(on: req.db)
            .filter(\.$id == groceryItemId)
            .first() else {
            throw Abort(.notFound)
        }
        
        try await groceryItem.delete(on: req.db)
        
        guard let groceryItemResponseDTO = GroceryItemResponseDTO(groceryItem) else {
            throw Abort(.internalServerError)
        }
        
        return groceryItemResponseDTO
    }
}
