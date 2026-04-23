//
//  Client.swift
//  OrionTek_Address_Gestor
//
//  Created by Negocios Agile on 4/22/26.
//

import Foundation

struct Client: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var email: String
    var phone: String
    var addresses: [Address]
    
    
    var initials: String {
        name
            .split(separator: " ")
            .prefix(2)
            .compactMap { $0.first }
            .map(String.init)
            .joined()
            .uppercased()
    }
    
    
    var addressesText: String {
        addresses.count == 1 ? "1 dirección" : "\(addresses.count) direcciones"
    }
    
    
    var avatarGradient: [String] {
        let gradients = [
            ["#667eea", "#764ba2"],
            ["#f093fb", "#f5576c"],
            ["#4facfe", "#00f2fe"],
            ["#43e97b", "#38f9d7"],
            ["#fa709a", "#fee140"],
            ["#30cfd0", "#330867"],
        ]
        
        let hash = abs(name.hashValue)
        let index = hash % gradients.count
        return gradients[index]
    }
    
    init(id: UUID = UUID(), name: String, email: String, phone: String, addresses: [Address] = []) {
        self.id = id
        self.name = name
        self.email = email
        self.phone = phone
        self.addresses = addresses
    }
}
