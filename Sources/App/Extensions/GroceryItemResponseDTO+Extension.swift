 //
//  File.swift
//  
//
//  Created by Adriana Torres on 12/28/23.
//

import Foundation
import AdriciaSharedDTO
import Vapor

extension GroceryItemResponseDTO: Content {
    init?(_ groceryItem: GroceryItem) {
        
        guard let id = groceryItem.id else {
            return nil
        }
        
        self.init(id: id, title: groceryItem.title)
    }
}
