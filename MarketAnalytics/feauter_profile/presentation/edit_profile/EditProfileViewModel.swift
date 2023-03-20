//
//  EditProfileViewModel.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 24/11/2022.
//

import Foundation
import PhotosUI
import _PhotosUI_SwiftUI
import FirebaseAuth

class EditProfileViewModel: ObservableObject {
    
    @Published var user: UserModel = UserModel(
        id: "",
        userName: ""
    )
    
    @Published var isPresentedRemoveAccount: Bool = false
    
    func saveData(vm: AppViewModel) {
        if !user.userName.isEmpty {
            vm.sendDataToDB(user: user)
        }
    }
    
    func removeAccount(vm: AppViewModel, completion: @escaping (Bool) -> ()) {
        if let user = Auth.auth().currentUser {
            user.delete { error in
                guard error == nil else {
                    completion(false)
                    return
                }
                
                vm.db.child("user").child(user.uid).removeValue()
                vm.user = nil
                vm.presentLogIn = true
                completion(true)
            }
        }
        
        completion(false)
    }
}
