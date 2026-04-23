//
//  Address.swift
//  OrionTek_Address_Gestor
//
//  Created by Negocios Agile on 4/22/26.
//


import Foundation

struct Address: Identifiable, Codable, Equatable {
    let id: UUID
    var label: String
    var street: String
    var city: String
    var state: String
    var isPrimary: Bool
    
    init(id: UUID = UUID(), label: String, street: String, city: String, state: String, isPrimary: Bool = false) {
        self.id = id
        self.label = label
        self.street = street
        self.city = city
        self.state = state
        self.isPrimary = isPrimary
    }
}
