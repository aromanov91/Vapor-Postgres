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

struct CreateActor: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        
        database.schema("actors")
            .id()
            .field("name", .string)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("actors").delete()
    }
    
}
