//
//  Card.swift
//  pruebaHiberus
//
//  Created by Jorge Johnson Riffarachy Garrido on 6/2/21.
//

import Foundation
struct Response: Codable {
    
    let cards: [Card]?
}

struct Card: Codable {
    
    let name: String?
    let manaCost: String?
    let text: String?
    let imageUrl: String?
   
}
