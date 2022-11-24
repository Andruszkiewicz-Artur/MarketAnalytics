//
//  RegistrationViewModel.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 17/11/2022.
//

import Foundation

class RegistrationViewModel: ObservableObject {
    
    //Data
    @Published var userName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var repassword: String = ""
    
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
    
    func signIn(vm: AppViewModel, vmNavigation: NavigationViewModel) {
        guard !userName.isEmpty, !email.isEmpty, !password.isEmpty, !repassword.isEmpty else {
            errorMessage = "Fill in all fields!"
            return
        }
        
        guard email.contains("@"), email.contains(".") else {
            errorMessage = "Email address is invalid!"
            return
        }
        
        guard password.count >= 8 else {
            errorMessage = "The password is too short!"
            return
        }
        
        guard password == repassword else {
            errorMessage = "The passwords not the same!"
            return
        }
        
        vm.auth.createUser(withEmail: self.email, password: self.password) { result, error in
            guard result != nil, error == nil else {
                self.errorMessage = "Problem with database!"
                return
            }
            
            vm.setUpUser()
            
            guard let id = vm.userId else {
                self.errorMessage = "Problem with database!"
                return
            }
                    
            vm.db.child("user").child(id).child("username").setValue(self.userName)
            vm.db.child("user").child(id).child("isAdmin").setValue(false)
            
            vmNavigation.backTooRoot(where: .login)
            vm.isSignedIn = true
        }
    }
    
    func hideErrorMessage() {
        errorMessage = ""
    }
}
