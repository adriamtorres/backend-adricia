//
//  User.swift
//
//
//  Created by Adriana Torres on 12/15/23.
//

import Foundation
import Fluent
import Vapor

final class User: Model, Content, Validatable {
    static let schema = "users"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "username")
    var username: String
    
    @Field(key: "password")
    var password: String
    
    init () { }
    
    init(id: UUID? = nil, username: String, password: String) {
        self.id = id
        self.username = username
        self.password = password
    }
    
    static func validations(_ validations: inout Validations) {
        validations.add("username", as: String.self, is: !.empty, customFailureDescription: "Username cannot be empty")
        validations.add("password", as: String.self, is: !.empty, customFailureDescription: "Password cannot be empty")
    }
}
