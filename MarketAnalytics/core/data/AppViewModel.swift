//
//  AppViewModel.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 17/11/2022.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class AppViewModel: ObservableObject {
    
    //ref
    let auth = Auth.auth()
    let db = Database.database().reference()
    let storage = Storage.storage().reference()
    
    //data
    var userId = Auth.auth().currentUser?.uid
    var isSignedIn: Bool = Auth.auth().currentUser == nil {
        didSet {
            userId = auth.currentUser?.uid
            setUpUserData()
            isSignedIn = !isSignedIn
        }
    }
    @Published var presentLogIn: Bool = Auth.auth().currentUser == nil
    @Published var user: UserModel? = nil
    let defaultUser = UserModel(id: "", userName: "")
    
    init() {
        setUpUserData()
    }
    
    func setUpUser() {
        userId = auth.currentUser?.uid
    }
    
    func removeUser() {
        userId = nil
    }
    
    func setUpUserData() {
        if let id = Auth.auth().currentUser?.uid {
            Database.database().reference().child("user").child(id).getData { error, snapshot in
                guard error == nil else {
                    return
                }
                
                guard let value = snapshot?.value as? NSDictionary else {
                    return
                }
                
                let userName = value["username"] as? String ?? ""
                
                self.user = UserModel(
                    id: id,
                    userName: userName
                )
            }
        }
    }
    
    func sendDataToDB(user: UserModel) {
        guard let id = auth.currentUser?.uid else {
            return
        }
        
        let path = db.child("user").child(id)
        
        path.child("username").setValue(user.userName)
        
        self.user = user
    }
}
