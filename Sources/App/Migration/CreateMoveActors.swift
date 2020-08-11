//
//  File.swift
//  
//
//  Created by 18391981 on 11.08.2020.
//

import Foundation
import Vapor
import Fluent
import FluentPostgresDriver

struct CreateMoveActors: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        
        database.schema("move_actors")
            .id()
            .field("move_id", .uuid, .required, .references("item", "id"))
            .field("actor_id", .uuid, .required, .references("actors", "id"))
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("move_actors").delete()
    }
    
}
