//
//  ForgetPasswordViewModel.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 17/11/2022.
//

import Foundation

class ForgetPasswordViewModel: ObservableObject {
    
    //Data
    @Published var email: String = ""
    
    //Alert
    @Published var errorMessage: String = "" {
        didSet {
            if errorMessage == "" {
                presentError = false
            } else {
                presentError = true
            }
        }
    }
    @Published var presentError: Bool = false
    @Published var isError: Bool = false
    
    func sendMessage(vm: AppViewModel) {
        isError = true
        
        guard email.isEmpty else {
            errorMessage = "Fill in email field!"
            return
        }
        
        vm.auth.sendPasswordReset(withEmail: email) { error in
            guard error == nil else {
                self.errorMessage = "Problem with sending message!"
                return
            }
            
            self.errorMessage = "Send email!"
            self.isError = false
        }
    }
    
    func hideAlert() {
        errorMessage = ""
    }
}
