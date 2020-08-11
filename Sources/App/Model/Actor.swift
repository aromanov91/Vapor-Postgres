//
//  File.swift
//  
//
//  Created by 18391981 on 11.08.2020.
//

import Foundation
import Fluent
import Vapor
import FluentPostgresDriver

final class Actor: Model, Content {
    
    static let schema = "actors"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Siblings(through: MoveActor.self, from: \.$actor, to: \.$moveId)
    var items: [MItem]
    
    init() {}
    
    init(id: UUID? = nil, name: String) {
        self.id = id
        self.name = name
    }
    
}
