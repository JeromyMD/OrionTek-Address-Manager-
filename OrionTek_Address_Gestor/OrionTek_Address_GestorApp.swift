//
//  OrionTek_Address_GestorApp.swift
//  OrionTek_Address_Gestor
//
//  Created by Negocios Agile on 4/22/26.
//

import SwiftUI


@main
struct OrionTek_Address_GestorApp: App {
    @StateObject private var viewmodel = ClientsViewModel()
    
    var body: some Scene {
        WindowGroup {
            ClientsListView().environmentObject(viewmodel)
        }
    }
}
