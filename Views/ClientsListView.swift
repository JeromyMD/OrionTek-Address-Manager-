//
//  ClientsListView.swift
//  OrionTek_Address_Gestor
//
//  Created by Negocios Agile on 4/22/26.
//


import SwiftUI

struct ClientsListView: View {
    @EnvironmentObject var viewModel: ClientsViewModel
    @State private var showingNewClient = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                Color.black.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    
                    HStack {
                        HStack(spacing: 8) {
                            Image("oriontek_logo")
                                   .resizable()
                                   .scaledToFit()
                                   .frame(height: 32)
                        }
                        
                        Spacer()
                        
                        Button(action: { showingNewClient = true }) {
                            Image(systemName: "plus")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(width: 50, height: 50)
                                .background(Color(hex: "#5E5CE6"))
                                .clipShape(Circle())
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                    .padding(.bottom, 24)
                    
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Clientes")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text("\(viewModel.clients.count) clientes · \(viewModel.totalAddresses) direcciones")
                            .font(.system(size: 15))
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 16)
                    
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Buscar cliente...", text: $viewModel.searchText)
                            .foregroundColor(.white)
                    }
                    .padding(12)
                    .background(Color(hex: "#1C1C1E"))
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 16)
                    
                    // Clients list
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(viewModel.filteredClients) { client in
                                NavigationLink(destination: ClientDetailView(client: client)) {
                                    ClientRowView(client: client)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                    }
                }
            }
            .sheet(isPresented: $showingNewClient) {
                NewClientView()
            }
        }
    }
}
