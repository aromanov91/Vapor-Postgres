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

final class MoveActor: Model {
    
    static let schema = "move_actors"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "move_id")
    var moveId: MItem
    
    @Parent(key: "actor_id")
    var actor: Actor
    
    init() {}
    
    init(moveId: UUID, actorId: UUID) {
        self.$moveId.id = moveId
        self.$actor.id = actorId
    }
    
}
