import Vapor

func routes(_ app: Application) throws {
    
//    app.get("item") { req in
//        MItem.query(on: req.db).all()
//    }
    
    app.post("item",":itemId","actor",":actorId") { req -> EventLoopFuture<HTTPStatus> in
        
        let item = MItem.find(req.parameters.get("itemId"), on: req.db)
            .unwrap(or: Abort(.notFound))
        
        let actor = Actor.find(req.parameters.get("actorId"), on: req.db)
            .unwrap(or: Abort(.notFound))
        
        return item.and(actor).flatMap { (move, actor) in
            move.$actors.attach(actor, on: req.db)
        }.transform(to: .ok)
    }
    
    app.get("actors") { req in
        Actor.query(on: req.db).with(\.$items).all()
    }
    
    app.post("actors") { req -> EventLoopFuture<Actor> in
        
        let actor = try req.content.decode(Actor.self)
        return actor.create(on: req.db).map { actor }
    }
    
    app.get("item") { req in
        MItem.query(on: req.db).with(\.$actors).with(\.$reviews).all()
    }
    
    app.get("item",":itemId") { req -> EventLoopFuture<MItem> in
        
        MItem.find(req.parameters.get("itemId"), on: req.db)
            .unwrap(or: Abort(.notFound))
        
    }
    
    app.put("item") { req -> EventLoopFuture<HTTPStatus> in
        
        let movie = try req.content.decode(MItem.self)
        
        return MItem.find(movie.id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap {
                $0.title = movie.title
                return $0.update(on: req.db).transform(to: .ok)
        }
    }
    
    app.delete("item", ":itemId") { req -> EventLoopFuture<HTTPStatus> in
        
        MItem.find( req.parameters.get("itemId"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap {
                $0.delete(on: req.db)
        }.transform(to: .ok)
    }
    
    app.post("item") { req -> EventLoopFuture<MItem> in
        
        let item = try req.content.decode(MItem.self)
        return item.create(on: req.db).map { item }
    }
    
    app.post("reviews") { req -> EventLoopFuture<Review> in
        
        let review = try req.content.decode(Review.self)
        return review.create(on: req.db).map { review }
        
    }
    
}
