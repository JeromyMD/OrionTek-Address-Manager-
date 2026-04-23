//
//  NewAddressView.swift
//  OrionTek_Address_Gestor
//
//  Created by Negocios Agile on 4/22/26.
//

import SwiftUI

struct NewAddressView: View {
    @EnvironmentObject var viewModel: ClientsViewModel
    @Environment(\.dismiss) var dismiss
    
    let client: Client
    let addressToEdit: Address?
    let onSave: ((Address) -> Void)?
    
    @State private var label: String = ""
    @State private var street: String = ""
    @State private var city: String = ""
    @State private var state: String = ""
    @State private var isPrimary: Bool = false
    
    init(client: Client, addressToEdit: Address? = nil, onSave: ((Address) -> Void)? = nil) {
        self.client = client
        self.addressToEdit = addressToEdit
        self.onSave = onSave
        
        _label = State(initialValue: addressToEdit?.label ?? "")
        _street = State(initialValue: addressToEdit?.street ?? "")
        _city = State(initialValue: addressToEdit?.city ?? "")
        _state = State(initialValue: addressToEdit?.state ?? "")
        _isPrimary = State(initialValue: addressToEdit?.isPrimary ?? false)
    }
    
    var isEditing: Bool {
        addressToEdit != nil
    }
    
    var canSave: Bool {
        !label.trimmingCharacters(in: .whitespaces).isEmpty &&
        !street.trimmingCharacters(in: .whitespaces).isEmpty &&
        !city.trimmingCharacters(in: .whitespaces).isEmpty &&
        !state.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("DIRECCIÓN")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(.gray)
                                .padding(.horizontal, 20)
                            
                            VStack(spacing: 0) {
                                
                                HStack {
                                    Text("Etiqueta")
                                        .font(.system(size: 16))
                                        .foregroundColor(.gray)
                                        .frame(width: 80, alignment: .leading)
                                    
                                    TextField("", text: $label)
                                        .font(.system(size: 16))
                                        .foregroundColor(.white)
                                }
                                .padding(16)
                                
                                Divider()
                                    .background(Color(hex: "#38383A"))
                                    .padding(.leading, 96)
                                
                                
                                HStack {
                                    Text("Calle")
                                        .font(.system(size: 16))
                                        .foregroundColor(.gray)
                                        .frame(width: 80, alignment: .leading)
                                    
                                    TextField("", text: $street)
                                        .font(.system(size: 16))
                                        .foregroundColor(.white)
                                }
                                .padding(16)
                                
                                Divider()
                                    .background(Color(hex: "#38383A"))
                                    .padding(.leading, 96)
                                
                                
                                HStack {
                                    Text("Ciudad")
                                        .font(.system(size: 16))
                                        .foregroundColor(.gray)
                                        .frame(width: 80, alignment: .leading)
                                    
                                    TextField("", text: $city)
                                        .font(.system(size: 16))
                                        .foregroundColor(.white)
                                }
                                .padding(16)
                                
                                Divider()
                                    .background(Color(hex: "#38383A"))
                                    .padding(.leading, 96)
                                
                                
                                HStack {
                                    Text("Provincia")
                                        .font(.system(size: 16))
                                        .foregroundColor(.gray)
                                        .frame(width: 80, alignment: .leading)
                                    
                                    TextField("", text: $state)
                                        .font(.system(size: 16))
                                        .foregroundColor(.white)
                                }
                                .padding(16)
                            }
                            .background(Color(hex: "#1C1C1E"))
                            .cornerRadius(10)
                            .padding(.horizontal, 20)
                        }
                        
                        
                        VStack(spacing: 0) {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Dirección principal")
                                        .font(.system(size: 16))
                                        .foregroundColor(.white)
                                    
                                    Text("Solo una por cliente")
                                        .font(.system(size: 13))
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                Toggle("", isOn: $isPrimary)
                                    .labelsHidden()
                            }
                            .padding(16)
                        }
                        .background(Color(hex: "#1C1C1E"))
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 40)
                }
            }
            .navigationTitle(isEditing ? "Editar dirección" : "Nueva dirección")
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
                        saveAddress()
                    }
                    .foregroundColor(canSave ? Color(hex: "#5E5CE6") : .gray)
                    .disabled(!canSave)
                }
            }
        }
    }
    
    private func saveAddress() {
        let trimmedLabel = label.trimmingCharacters(in: .whitespaces)
        let trimmedStreet = street.trimmingCharacters(in: .whitespaces)
        let trimmedCity = city.trimmingCharacters(in: .whitespaces)
        let trimmedState = state.trimmingCharacters(in: .whitespaces)
        
        let newAddress = Address(
            id: addressToEdit?.id ?? UUID(),
            label: trimmedLabel,
            street: trimmedStreet,
            city: trimmedCity,
            state: trimmedState,
            isPrimary: isPrimary
        )
        
        if let onSave = onSave {
            
            onSave(newAddress)
        } else if isEditing {
            
            viewModel.updateAddress(for: client, address: newAddress)
        } else {
            
            viewModel.addAddress(to: client, address: newAddress)
        }
        
        dismiss()
    }
}
