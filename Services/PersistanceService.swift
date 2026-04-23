//
//  PersistanceService.swift
//  OrionTek_Address_Gestor
//
//  Created by Negocios Agile on 4/22/26.
//

import Foundation

class PersistenceService {
    static let shared = PersistenceService()
    
    private let clientsKey = "saved_clients"
    
    private init() {}
    
    
    func saveClients(_ clients: [Client]) {
        do {
            let data = try JSONEncoder().encode(clients)
            UserDefaults.standard.set(data, forKey: clientsKey)
        } catch {
            print("Error saving clients: \(error.localizedDescription)")
        }
    }
    
    
    func loadClients() -> [Client] {
        guard let data = UserDefaults.standard.data(forKey: clientsKey) else {
            return []
        }
        
        do {
            let clients = try JSONDecoder().decode([Client].self, from: data)
            return clients
        } catch {
            print("Error loading clients: \(error.localizedDescription)")
            return []
        }
    }
}
