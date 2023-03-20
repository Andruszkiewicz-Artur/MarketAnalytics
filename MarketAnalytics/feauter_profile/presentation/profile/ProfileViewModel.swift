//
//  ProfileViewModel.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 22/11/2022.
//

import Foundation

class ProfileViewModel: ObservableObject {
    
    @Published var user = UserModel(id: "", userName: "")
    
    func logOut(vm: AppViewModel, vmNavigation: NavigationViewModel) {
        
        do {
            try vm.auth.signOut()
            vm.removeUser()
            vmNavigation.backTooRoot(where: .standard)
            vm.presentLogIn = true
            vm.user = nil
            print("Log Out")
        } catch {
            print(error)
        }
    }
}
