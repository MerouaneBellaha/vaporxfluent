//
//  File.swift
//  
//
//  Created by Merouane Bellaha on 01/01/2022.
//

import Foundation
import Fluent
import Vapor

final class Movie: Model, Content {
    static let schema = "movies"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    init() {}
    
    init(id: UUID? = nil, title: String) {
        self.id = id
        self.title = title
    }
}
