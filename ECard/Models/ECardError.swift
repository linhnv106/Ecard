//
//  AmareError.swift
//  AmareLife
//
//  Created by Anton Poluboiarynov on 1/18/19.
//  Copyright © 2019 Amare Global. All rights reserved.
//

struct ECardError: Error, Equatable, Codable {
    enum CodingKeys: String, CodingKey {
        case error = "error"
        case description = "error_description"
    }
    
    let error: String?
    let description: String?
}
