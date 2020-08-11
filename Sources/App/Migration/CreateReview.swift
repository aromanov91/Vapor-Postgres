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

struct CreateReview: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        
        database.schema("reviews")
            .id()
            .field("title", .string)
            .field("body", .string)
            .field("move_id", .uuid, .references("item", "id"))
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("reviews").delete()
    }
    
}
