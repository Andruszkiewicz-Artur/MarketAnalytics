//
//  SettingsView.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 20/11/2022.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject private var vmApp: AppViewModel
    @EnvironmentObject private var vmNavigation: NavigationViewModel
    @StateObject private var vm: SettingsViewModel = SettingsViewModel()
    @Environment(\.dismiss) private var dismiss
    
    
    
    var body: some View {
        List {
            Section {
                NavigationLink(value: "EditProfile") {
                    Text("Edit profile")
                }
                
                NavigationLink(value: "ChangePasswordProfile") {
                    Text("Change password")
                }
            }
            
            Section {
                HStack {
                    Spacer()
                    Text("Log Out")
                        .foregroundColor(Color.red)
                        .onTapGesture(count: 1) {
                            vm.logOut(vm: vmApp, vmNavigation: vmNavigation)
                            dismiss()
                        }
                    Spacer()
                }
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
