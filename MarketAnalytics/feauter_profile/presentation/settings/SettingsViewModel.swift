//
//  SettingsViewModel.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 20/11/2022.
//

import Foundation
import SwiftUI

class SettingsViewModel: ObservableObject {
    
    func logOut(vm: AppViewModel, vmNavigation: NavigationViewModel) {
        
        do {
            try vm.auth.signOut()
            vm.removeUser()
            vmNavigation.backTooRoot(where: .standard)
            vm.isSignedIn = false
            vm.user = nil
        } catch {
            print(error)
        }
    }
}
