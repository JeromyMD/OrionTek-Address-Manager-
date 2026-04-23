//
//  NewClientView.swift
//  OrionTek_Address_Gestor
//
//  Created by Negocios Agile on 4/22/26.
//

import SwiftUI

struct NewClientView: View {
    @EnvironmentObject var viewModel: ClientsViewModel
    @Environment(\.dismiss) var dismiss
    
    let clientToEdit: Client?
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var addresses: [Address] = []
    @State private var showingNewAddress = false
    
    init(clientToEdit: Client? = nil) {
        self.clientToEdit = clientToEdit
        
        
        _name = State(initialValue: clientToEdit?.name ?? "")
        _email = State(initialValue: clientToEdit?.email ?? "")
        _phone = State(initialValue: clientToEdit?.phone ?? "")
        _addresses = State(initialValue: clientToEdit?.addresses ?? [])
    }
    
    var isEditing: Bool {
        clientToEdit != nil
    }
    
    var canSave: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty &&
        !email.trimmingCharacters(in: .whitespaces).isEmpty &&
        !phone.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("INFORMACIÓN")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(.gray)
                                .padding(.horizontal, 20)
                            
                            VStack(spacing: 0) {
                                
                                HStack {
                                    Text("Nombre")
                                        .font(.system(size: 16))
                                        .foregroundColor(.gray)
                                        .frame(width: 80, alignment: .leading)
                                    
                                    TextField("", text: $name)
                                        .font(.system(size: 16))
                                        .foregroundColor(.white)
                                }
                                .padding(16)
                                
                                Divider()
                                    .background(Color(hex: "#38383A"))
                                    .padding(.leading, 96)
                                
                                
                                HStack {
                                    Text("Email")
                                        .font(.system(size: 16))
                                        .foregroundColor(.gray)
                                        .frame(width: 80, alignment: .leading)
                                    
                                    TextField("", text: $email)
                                        .font(.system(size: 16))
                                        .foregroundColor(.white)
                                        .keyboardType(.emailAddress)
                                        .autocapitalization(.none)
                                }
                                .padding(16)
                                
                                Divider()
                                    .background(Color(hex: "#38383A"))
                                    .padding(.leading, 96)
                                
                                
                                HStack {
                                    Text("Teléfono")
                                        .font(.system(size: 16))
                                        .foregroundColor(.gray)
                                        .frame(width: 80, alignment: .leading)
                                    
                                    TextField("", text: $phone)
                                        .font(.system(size: 16))
                                        .foregroundColor(.white)
                                        .keyboardType(.phonePad)
                                }
                                .padding(16)
                            }
                            .background(Color(hex: "#1C1C1E"))
                            .cornerRadius(10)
                            .padding(.horizontal, 20)
                        }
                        
                        
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text("DIRECCIONES")
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundColor(.gray)
                                
                                Spacer()
                                
                                Button(action: { showingNewAddress = true }) {
                                    HStack(spacing: 4) {
                                        Image(systemName: "plus")
                                            .font(.system(size: 13, weight: .semibold))
                                        Text("Agregar")
                                            .font(.system(size: 14, weight: .semibold))
                                    }
                                    .foregroundColor(Color(hex: "#5E5CE6"))
                                }
                            }
                            .padding(.horizontal, 20)
                            
                            if addresses.isEmpty {
                                VStack(spacing: 12) {
                                    Button(action: { showingNewAddress = true }) {
                                        HStack {
                                            Image(systemName: "plus.circle.fill")
                                                .font(.system(size: 20))
                                                .foregroundColor(Color(hex: "#5E5CE6"))
                                            
                                            Text("Agregar otra dirección")
                                                .font(.system(size: 16))
                                                .foregroundColor(.white)
                                            
                                            Spacer()
                                        }
                                        .padding(16)
                                        .background(Color(hex: "#1C1C1E"))
                                        .cornerRadius(10)
                                    }
                                }
                                .padding(.horizontal, 20)
                            } else {
                                VStack(spacing: 12) {
                                    ForEach(addresses) { address in
                                        NavigationLink(destination: Text(address.label)) {
                                            HStack(spacing: 12) {
                                                Image(systemName: "mappin.circle.fill")
                                                    .font(.system(size: 20))
                                                    .foregroundColor(Color(hex: "#8E8E93"))
                                                
                                                Text(address.label)
                                                    .font(.system(size: 16))
                                                    .foregroundColor(.white)
                                                
                                                Spacer()
                                                
                                                Image(systemName: "chevron.right")
                                                    .font(.system(size: 14))
                                                    .foregroundColor(.gray)
                                            }
                                            .padding(16)
                                            .background(Color(hex: "#1C1C1E"))
                                            .cornerRadius(10)
                                        }
                                    }
                                    
                                    Button(action: { showingNewAddress = true }) {
                                        HStack {
                                            Image(systemName: "plus.circle.fill")
                                                .font(.system(size: 20))
                                                .foregroundColor(Color(hex: "#5E5CE6"))
                                            
                                            Text("Agregar otra dirección")
                                                .font(.system(size: 16))
                                                .foregroundColor(.white)
                                            
                                            Spacer()
                                        }
                                        .padding(16)
                                        .background(Color(hex: "#1C1C1E"))
                                        .cornerRadius(10)
                                    }
                                }
                                .padding(.horizontal, 20)
                            }
                        }
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 40)
                }
            }
            .navigationTitle(isEditing ? "Editar cliente" : "Nuevo cliente")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") {
                        dismiss()
                    }
                    .foregroundColor(Color(hex: "#5E5CE6"))
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Guardar") {
                        saveClient()
                    }
                    .foregroundColor(canSave ? Color(hex: "#5E5CE6") : .gray)
                    .disabled(!canSave)
                }
            }
            .sheet(isPresented: $showingNewAddress) {
                
                let tempClient = Client(
                    id: clientToEdit?.id ?? UUID(),
                    name: name.isEmpty ? "Nuevo Cliente" : name,
                    email: email,
                    phone: phone,
                    addresses: addresses
                )
                
                NewAddressView(
                    client: tempClient,
                    onSave: { newAddress in
                        addresses.append(newAddress)
                    }
                )
            }
        }
    }
    
    private func saveClient() {
        let trimmedName = name.trimmingCharacters(in: .whitespaces)
        let trimmedEmail = email.trimmingCharacters(in: .whitespaces)
        let trimmedPhone = phone.trimmingCharacters(in: .whitespaces)
        
        if isEditing, let existingClient = clientToEdit {
            let updatedClient = Client(
                id: existingClient.id,
                name: trimmedName,
                email: trimmedEmail,
                phone: trimmedPhone,
                addresses: addresses
            )
            viewModel.updateClient(updatedClient)
        } else {
            let newClient = Client(
                name: trimmedName,
                email: trimmedEmail,
                phone: trimmedPhone,
                addresses: addresses
            )
            viewModel.addClient(newClient)
        }
        
        dismiss()
    }
}
