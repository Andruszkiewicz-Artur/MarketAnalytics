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
 
    func logIn(vm: AppViewModel, vmNavigation: NavigationViewModel, completion: @escaping (Bool) -> ()) {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Fill in all fields!"
            completion(false)
            return
        }
            
        vm.auth.signIn(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                self.errorMessage = "Data are not correct!"
                completion(false)
                return
            }
            
            vmNavigation.backTooRoot(where: .login)
            vm.isSignedIn = true
            vm.presentLogIn = false
            completion(true)
        }
    }
    
    func hideError() {
        errorMessage = ""
    }
}
