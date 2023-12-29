//
//  File.swift
//  
//
//  Created by Adriana Torres on 12/28/23.
//

import Foundation
import Fluent
import Vapor

final class GroceryItem: Model, Content, Validatable {
    static let schema = "grocery_items"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    init () { }
    
    init(id: UUID? = nil, title: String) {
        self.id = id
        self.title = title
    }
    
    static func validations(_ validations: inout Validations) {
        validations.add("title", as: String.self, is: !.empty, customFailureDescription: "item cannot be empty")
    }
}
 
