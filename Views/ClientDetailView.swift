//
//  ClientDetailView.swift
//  OrionTek_Address_Gestor
//
//  Created by Negocios Agile on 4/22/26.
//

import SwiftUI

struct ClientDetailView: View {
    @EnvironmentObject var viewModel: ClientsViewModel
    @Environment(\.dismiss) var dismiss
    
    let client: Client
    
    @State private var showingEditClient = false
    @State private var showingNewAddress = false
    @State private var showingDeleteAlert = false
    @State private var addressToEdit: Address?
    @State private var addressToDelete: Address?
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    
                    VStack(spacing: 20) {
                        
                        VStack(spacing: 16) {
                            AvatarView(
                                initials: client.initials,
                                gradientColors: client.avatarGradient,
                                size: 80
                            )
                            
                            Text(client.name)
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                        }
                        
                        
                        VStack(spacing: 12) {
                            HStack(spacing: 12) {
                                Image(systemName: "envelope.fill")
                                    .foregroundColor(Color(hex: "#8E8E93"))
                                
                                Text(client.email)
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                                
                                Spacer()
                            }
                            .padding(16)
                            .background(Color(hex: "#2C2C2E"))
                            .cornerRadius(8)
                            
                            HStack(spacing: 12) {
                                Image(systemName: "phone.fill")
                                    .foregroundColor(Color(hex: "#8E8E93"))
                                
                                Text(client.phone)
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                                
                                Spacer()
                            }
                            .padding(16)
                            .background(Color(hex: "#2C2C2E"))
                            .cornerRadius(8)
                        }
                    }
                    .padding(20)
                    
                    
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Direcciones (\(currentClient.addresses.count))")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Button(action: { showingNewAddress = true }) {
                                HStack(spacing: 4) {
                                    Image(systemName: "plus")
                                        .font(.system(size: 14, weight: .semibold))
                                    Text("Agregar")
                                        .font(.system(size: 15, weight: .semibold))
                                }
                                .foregroundColor(Color(hex: "#5E5CE6"))
                            }
                        }
                        
                        if currentClient.addresses.isEmpty {
                            Text("No hay direcciones registradas")
                                .font(.system(size: 15))
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.vertical, 40)
                        } else {
                            ForEach(currentClient.addresses) { address in
                                AddressCardView(
                                    address: address,
                                    onEdit: { addressToEdit = address },
                                    onDelete: { addressToDelete = address }
                                )
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack(spacing: 16) {
                    Button(action: { showingEditClient = true }) {
                        Image(systemName: "pencil")
                            .foregroundColor(.white)
                    }
                    
                    Button(action: { showingDeleteAlert = true }) {
                        Image(systemName: "trash.fill")
                            .foregroundColor(Color(hex: "#FF453A"))
                    }
                }
            }
        }
        .sheet(isPresented: $showingNewAddress) {
            NewAddressView(client: currentClient)
        }
        .sheet(item: $addressToEdit) { address in
            NewAddressView(client: currentClient, addressToEdit: address)
        }
        .sheet(isPresented: $showingEditClient) {
            NewClientView(clientToEdit: currentClient)
        }
        .alert("Eliminar dirección", isPresented: Binding(
            get: { addressToDelete != nil },
            set: { if !$0 { addressToDelete = nil } }
        )) {
            Button("Cancelar", role: .cancel) {
                addressToDelete = nil
            }
            Button("Eliminar", role: .destructive) {
                if let address = addressToDelete {
                    viewModel.deleteAddress(from: currentClient, address: address)
                    addressToDelete = nil
                }
            }
        } message: {
            Text("¿Estás seguro de que deseas eliminar esta dirección?")
        }
        .alert("Eliminar cliente", isPresented: $showingDeleteAlert) {
            Button("Cancelar", role: .cancel) {}
            Button("Eliminar", role: .destructive) {
                viewModel.deleteClient(client)
                dismiss()
            }
        } message: {
            Text("¿Estás seguro de que deseas eliminar este cliente? Esta acción no se puede deshacer.")
        }
    }
    
    
    private var currentClient: Client {
        viewModel.clients.first(where: { $0.id == client.id }) ?? client
    }
}
