//
//  SweetProduct.swift
//  SweetSensation
//
//  Created by D K on 20.10.2024.
//

import Foundation

class SweetProduct: Codable {
    let name: String
    let price: String
    let description: String
    let type: String
    
    init(name: String, price: String, description: String, type: String) {
        self.name = name
        self.price = price
        self.description = description
        self.type = type
    }
}
