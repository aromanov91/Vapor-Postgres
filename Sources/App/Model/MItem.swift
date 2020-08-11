//
//  File.swift
//  
//
//  Created by 18391981 on 10.08.2020.
//

import Foundation
import Fluent
import Vapor
import FluentPostgresDriver

final class MItem: Model, Content {
    
    static let schema = "item"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Children(for: \.$item)
    var reviews: [Review]
    
    @Siblings(through: MoveActor.self, from: \.$moveId, to: \.$actor)
    var actors: [Actor]
    
    init() {}
    
    init(id: UUID? = nil, title: String) {
        self.id = id
        self.title = title
    }
    
}
