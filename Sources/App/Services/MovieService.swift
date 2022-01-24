//
//  File.swift
//  
//
//  Created by Merouane Bellaha on 01/01/2022.
//

import Foundation
import Vapor

protocol MovieServiceInterface {
    func create(on req: Request) throws -> EventLoopFuture<Movie>
    func getAll(on req: Request) throws -> EventLoopFuture<[Movie]>
    func getById(_ id: UUID, on req: Request) throws -> EventLoopFuture<Movie>
    func update(_ movie: Movie, on req: Request) throws -> EventLoopFuture<Void>
    func delete(_ id: UUID, on req: Request) throws -> EventLoopFuture<Void>
}

struct MovieService: MovieServiceInterface {
    
    let movieDao: MovieDaoInterface
    
    init(movieDao: MovieDaoInterface = MovieDao()) {
        self.movieDao = movieDao
    }
    
    func create(on req: Request) throws -> EventLoopFuture<Movie> {
        let movie = try req.content.decode(Movie.self)
        return try movieDao.create(movie, on: req)
    }
    
    func getAll(on req: Request) throws -> EventLoopFuture<[Movie]> {
        return try movieDao.getAll(on: req)
    }
    
    func getById(_ id: UUID, on req: Request) throws -> EventLoopFuture<Movie> {
        return try movieDao.getById(id, on: req)
            .unwrap(or: FunctionalError.notFound)
    }
    
    func update(_ movie: Movie, on req: Request) throws -> EventLoopFuture<Void> {
        guard let uuid = movie.id else { throw Abort(.badRequest) }
        
        return try movieDao.getById(uuid, on: req)
            .unwrap(or: FunctionalError.notFound)
            .flatMap { movieToUpdate -> EventLoopFuture<Void> in
                movieToUpdate.title = movie.title
                do { return try movieDao.update(movieToUpdate, on: req) }
                catch { return req.eventLoop.makeFailedFuture(error) }
            }
    }
    
    func delete(_ id: UUID, on req: Request) throws -> EventLoopFuture<Void> {
        return try movieDao.getById(id, on: req)
            .unwrap(or: FunctionalError.notFound)
            .flatMap { movieToDelete -> EventLoopFuture<Void> in
                do { return try movieDao.delete(movieToDelete, on: req) }
                catch { return req.eventLoop.makeFailedFuture(error) }
            }
    }
}

enum FunctionalError: Error {
    case notFound
}
