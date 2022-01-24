//
//  File.swift
//  
//
//  Created by Merouane Bellaha on 01/01/2022.
//

import Foundation
import Vapor

struct MovieController: RouteCollection {
    
    let movieService: MovieServiceInterface
    
    init(movieService: MovieServiceInterface = MovieService()) {
        self.movieService = movieService
    }
    
    
    func boot(routes: RoutesBuilder) throws {
        let movies = routes.grouped("movies")
        
        movies.post(use: create)
        
        movies.get(use: getAll)
        
        movies.get(":id", use: getById)
        
        movies.put(use: update)
        
        movies.delete(":id", use: delete)
    }
    
    
    private func create(req: Request) throws -> EventLoopFuture<Movie> {
        return try movieService.create(on: req)
    }
    
    private func getAll(req: Request) throws -> EventLoopFuture<[Movie]> {
        return try movieService.getAll(on: req)
    }
    
    private func getById(req: Request) throws -> EventLoopFuture<Movie> {
        let uuid = try req.getUuidFrom("id")
        return try movieService.getById(uuid, on: req)
    }
    
    private func update(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let movie = try req.content.decode(Movie.self)
        return try movieService.update(movie, on: req).transform(to: .ok)
    }
    
    private func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let uuid = try req.getUuidFrom("id")
        return try movieService.delete(uuid, on: req).transform(to: .ok)
    }
}
