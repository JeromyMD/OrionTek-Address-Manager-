//
//  ClientsViewModel.swift
//  OrionTek_Address_Gestor
//
//  Created by Negocios Agile on 4/22/26.
//

import Foundation
import SwiftUI

class ClientsViewModel: ObservableObject {
    @Published var clients: [Client] = []
    @Published var searchText: String = ""
    
    
    var filteredClients: [Client] {
        if searchText.isEmpty {
            return clients
        }
        return clients.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    
    var totalAddresses: Int {
        clients.reduce(0) { $0 + $1.addresses.count }
    }
    
    init() {
        loadClients()
    }
    
    
    
    func addClient(_ client: Client) {
        clients.append(client)
        saveClients()
    }
    
    func updateClient(_ updatedClient: Client) {
        if let index = clients.firstIndex(where: { $0.id == updatedClient.id }) {
            clients[index] = updatedClient
            saveClients()
        }
    }
    
    func deleteClient(_ client: Client) {
        clients.removeAll { $0.id == client.id }
        saveClients()
    }
    
    
    
    func addAddress(to client: Client, address: Address) {
        guard let index = clients.firstIndex(where: { $0.id == client.id }) else { return }
        
        var updatedClient = clients[index]
        
        
        if address.isPrimary {
            updatedClient.addresses = updatedClient.addresses.map {
                var addr = $0
                addr.isPrimary = false
                return addr
            }
        }
        
        updatedClient.addresses.append(address)
        clients[index] = updatedClient
        saveClients()
    }
    
    func updateAddress(for client: Client, address: Address) {
        guard let clientIndex = clients.firstIndex(where: { $0.id == client.id }),
              let addressIndex = clients[clientIndex].addresses.firstIndex(where: { $0.id == address.id }) else {
            return
        }
        
        var updatedClient = clients[clientIndex]
        
        
        if address.isPrimary {
            updatedClient.addresses = updatedClient.addresses.map {
                var addr = $0
                if addr.id != address.id {
                    addr.isPrimary = false
                }
                return addr
            }
        }
        
        updatedClient.addresses[addressIndex] = address
        clients[clientIndex] = updatedClient
        saveClients()
    }
    
    func deleteAddress(from client: Client, address: Address) {
        guard let clientIndex = clients.firstIndex(where: { $0.id == client.id }) else { return }
        
        var updatedClient = clients[clientIndex]
        updatedClient.addresses.removeAll { $0.id == address.id }
        clients[clientIndex] = updatedClient
        saveClients()
    }
    
    
    
    private func saveClients() {
        PersistenceService.shared.saveClients(clients)
    }
    
    private func loadClients() {
        clients = PersistenceService.shared.loadClients()
    }
}
