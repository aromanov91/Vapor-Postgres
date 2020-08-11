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

final class Review: Model, Content  {
    
    static var schema = "reviews"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "body")
    var body: String
    
    @Parent(key: "move_id")
    var item: MItem
    
    init() {}
    
    init(id: UUID? = nil, title: String, body: String, itemId: UUID) {
        self.id = id
        self.title = title
        self.body = body
        self.$item.id = itemId
    }
}
