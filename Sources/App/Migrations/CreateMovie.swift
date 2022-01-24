//
//  File.swift
//  
//
//  Created by Merouane Bellaha on 01/01/2022.
//

import Foundation
import Fluent
import FluentPostgresDriver

struct CreateMovie: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("movies")
            .id()
            .field("title", .string, .required)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("movies").delete()
    }
}
