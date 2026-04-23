//
//  ClientRowView.swift
//  OrionTek_Address_Gestor
//
//  Created by Negocios Agile on 4/22/26.
//


import SwiftUI

struct ClientRowView: View {
    let client: Client
    
    var body: some View {
        HStack(spacing: 16) {
            
            AvatarView(
                initials: client.initials,
                gradientColors: client.avatarGradient,
                size: 60
            )
            
            
            VStack(alignment: .leading, spacing: 4) {
                Text(client.name)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
                
                HStack(spacing: 4) {
                    Image(systemName: "mappin.circle.fill")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    
                    Text(client.addressesText)
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
            
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.gray)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 20)
        .background(Color(hex: "#1C1C1E"))
        .cornerRadius(12)
    }
}
