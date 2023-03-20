//
//  ChangeEmailViewModel.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 24/11/2022.
//

import Foundation

class ChangeEmailViewModel: ObservableObject {

    //Data
    @Published var currentEmail: String = ""
    @Published var email: String = ""
    
    //Alert
    @Published var errorMessage: String = "" {
        didSet {
            if !errorMessage.isEmpty {
                presentAlert = true
            }
        }
    }
    @Published var presentAlert: Bool = false
    
    func changeEmail(vm: AppViewModel) -> ResultEnum {
        
        guard email.contains("@"), email.contains(".") else {
            errorMessage = "Email address is invalid!"
            return .error
        }
        
        vm.auth.currentUser?.updateEmail(to: email) { error in
            guard error == nil else {
                self.errorMessage = "Problem with changing email or you need log out and login again!"
                return
            }
        }
        
        return errorMessage.isEmpty ? .success : .error
    }
    
    func hideAlert() {
        errorMessage = ""
    }
}
