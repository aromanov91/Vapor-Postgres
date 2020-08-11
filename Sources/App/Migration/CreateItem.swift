//
//  File.swift
//  
//
//  Created by 18391981 on 09.08.2020.


import Vapor
import Fluent
import FluentPostgresDriver

struct CreateItem: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        
        database.schema("item")
            .id()
            .field("title", .string)
            .create()
        
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("item").delete()
    }
    
    
    
}
