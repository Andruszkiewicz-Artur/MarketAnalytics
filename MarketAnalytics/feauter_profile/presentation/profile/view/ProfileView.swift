//
//  ProfileView.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 16/11/2022.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject private var vmApp: AppViewModel
    @StateObject private var vm: ProfileViewModel = ProfileViewModel()
    @EnvironmentObject private var vmNavigation: NavigationViewModel

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
                
                NavigationLink(value: "ChangeEmailProfile") {
                    Text("Change email")
                }
            }
            
            Section {
                HStack {
                    Spacer()
                    Text("Log Out")
                        .foregroundColor(Color.red)
                        .onTapGesture(count: 1) {
                            vm.logOut(vm: vmApp, vmNavigation: vmNavigation)
                        }
                    Spacer()
                }
            }
        }
        .accentColor(.primary)
        .onAppear {
            vmNavigation.selectionTab = 2
        }
        .toolbar {
            if vmNavigation.selectionTab == 2 {
                ToolbarItem(placement: .principal) {
                    Text(vmApp.user?.userName ?? "username")
                }
            }
        }

    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
