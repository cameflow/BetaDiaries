//
//  Beta.swift
//  BetaDiaries
//
//  Created by Alejandro Terrazas on 29/09/20.
//

import Foundation

struct Beta: Comparable {
    
    var id: String
    var grade: String?
    var name: String
    var description: String
    var isSlab: Bool?
    
    init(id: String, name: String, description: String) {
        self.id             = id
        self.name           = name
        self.description    = description
    }
    
    static func <(lhs: Beta, rhs: Beta) -> Bool {
            return lhs.name < rhs.name
        }
    
}
