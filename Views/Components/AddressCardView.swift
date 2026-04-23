//
//  AddressCardView.swift
//  OrionTek_Address_Gestor
//
//  Created by Negocios Agile on 4/22/26.
//

import SwiftUI

struct AddressCardView: View {
    let address: Address
    let onEdit: () -> Void
    let onDelete: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "mappin.circle.fill")
                        .font(.system(size: 20))
                        .foregroundColor(Color(hex: "#8E8E93"))
                    
                    Text(address.label)
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                    
                    if address.isPrimary {
                        Text("PRINCIPAL")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color(hex: "#5E5CE6"))
                            .cornerRadius(4)
                    }
                }
                
                Spacer()
                
                HStack(spacing: 12) {
                    Button(action: onEdit) {
                        Image(systemName: "pencil")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                    }
                    
                    Button(action: onDelete) {
                        Image(systemName: "trash.fill")
                            .font(.system(size: 16))
                            .foregroundColor(Color(hex: "#FF453A"))
                    }
                }
            }
            .padding(16)
            
            Divider()
                .background(Color(hex: "#38383A"))
            
            
            VStack(alignment: .leading, spacing: 8) {
                Text(address.street)
                    .font(.system(size: 15))
                    .foregroundColor(.white)
                
                Text("\(address.city), \(address.state)")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
        }
        .background(Color(hex: "#1C1C1E"))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(address.isPrimary ? Color(hex: "#5E5CE6") : Color.clear, lineWidth: 1)
        )
    }
}
