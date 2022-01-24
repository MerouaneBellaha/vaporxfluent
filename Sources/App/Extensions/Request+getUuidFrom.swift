//
//  File.swift
//  
//
//  Created by Merouane Bellaha on 24/01/2022.
//

import Vapor

extension Request {
    func getUuidFrom(_ id: String) throws -> UUID {
        guard let id = self.parameters.get(id),
              let uuid = UUID(uuidString: id) else { throw Abort(.badRequest) }
        return uuid
    }
}
