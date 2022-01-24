//
//  File.swift
//  
//
//  Created by Merouane Bellaha on 01/01/2022.
//

import Foundation
import Vapor

protocol MovieDaoInterface {
    func create(_ movie: Movie, on req: Request) throws -> EventLoopFuture<Movie>
    func getAll(on req: Request) throws -> EventLoopFuture<[Movie]>
    func getById(_ id: UUID, on req: Request) throws -> EventLoopFuture<Movie?>
    func update(_ movie: Movie, on req: Request) throws -> EventLoopFuture<Void>
    func delete(_ movie: Movie, on req: Request) throws -> EventLoopFuture<Void>
}

struct MovieDao: MovieDaoInterface {
    
    
    func create(_ movie: Movie, on req: Request) throws -> EventLoopFuture<Movie> {
        movie.create(on: req.db).map { movie }
    }
    
    func getAll(on req: Request) throws -> EventLoopFuture<[Movie]> {
        Movie.query(on: req.db).all()
    }
    
    func getById(_ id: UUID, on req: Request) throws -> EventLoopFuture<Movie?> {
        Movie.find(id, on: req.db)
    }
    
    func update(_ movie: Movie, on req: Request) throws -> EventLoopFuture<Void> {
        movie.update(on: req.db)
    }
    
    func delete(_ movie: Movie, on req: Request) throws -> EventLoopFuture<Void> {
        movie.delete(on: req.db)
    }
}
