//
//  ChangePasswordViewModel.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 24/11/2022.
//

import Foundation

class ChangePasswordViewModel: ObservableObject {
    
    //Data
    @Published var password: String = ""
    @Published var rePassword: String = ""
    
    //Alert
    @Published var presentMessage: String = "" {
        didSet {
            if !presentMessage.isEmpty {
                presentAlert = true
            }
        }
    }
    @Published var presentAlert: Bool = false
    
    func resetPassword(vm: AppViewModel) -> ResultEnum {
        
        guard password.count >= 8 else {
            presentMessage = "The password is too short!"
            return .error
        }
        
        guard password == rePassword else {
            presentMessage = "The passwords not the same!"
            return .error
        }
        
        vm.auth.currentUser?.updatePassword(to: password) { error in
            guard error == nil else {
                self.presentMessage = "Problem with changing password or you need logOut and login again!"
                return
            }
        }
        
        return presentMessage.isEmpty ? .success : .error
    }
    
    func hideAlert() {
        presentMessage = ""
    }
    
}
