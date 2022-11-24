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
    
    var body: some View {
        VStack {
            TopBarProfileView(user: vm.user)
            
            DescriptionProfileView(description: vm.user.description)
            
            OpinionsProfileView(opinions: vm.user.opinions)
            
            Spacer()
        }
        .padding([.leading, .trailing])
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(value: "Settings") {
                    Image(systemName: "gearshape")
                        .foregroundColor(Color.primary)
                }
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                Text(vmApp.user?.userName ?? "")
                    .font(.title2)
            }
        }
        .navigationDestination(for: String.self) { string in
            switch string {
                case "Settings": do {
                    SettingsView()
                }
                case "EditProfile": do {
                    EditProfileView()
                }
                case "ChangePasswordProfile": do {
                    ChangePasswordView()
                }
                default: do {  }
            }
        }
        .navigationTitle("Account")
        .accentColor(.primary)
        .onAppear {
            if let user = vmApp.user {
                vm.user = user
            }
        }
//        .onChange(of: vmApp.user) { newValue in
//            if let user = vmApp.user {
//                vm.user = user
//            }
//        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
