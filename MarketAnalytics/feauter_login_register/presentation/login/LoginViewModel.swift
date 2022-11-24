//
//  LoginViewModel.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 17/11/2022.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    //Data
    @Published var email: String = ""
    @Published var password: String = ""
    
    //Error
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
 
    func logIn(vm: AppViewModel, vmNavigation: NavigationViewModel) {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Fill in all fields!"
            return
        }
            
        vm.auth.signIn(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                self.errorMessage = "Data are not correct!"
                return
            }
            
            vmNavigation.backTooRoot(where: .login)
            vm.isSignedIn = true
        }
        
        print(vm.isSignedIn)
    }
    
    func hideError() {
        errorMessage = ""
    }
    
}
