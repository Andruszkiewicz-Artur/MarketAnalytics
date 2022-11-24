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
        }
    }
    var user: UserModel? = nil
    let defaultUser = UserModel(id: "", userName: "", likes: 0, dislikes: 0, description: "", isAdmin: false, opinions: [])
    
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
                let description = value["description"] as? String ?? ""
                let imageId = value["image"] as? Int ?? 0
                let isAdmin = value["isAdmin"] as? Bool ?? false
                var image: Data? = nil
                
                self.storage.child("image").child("\(imageId).jpg").getData(maxSize: 1 * 1024 * 1024 * 24) { data, error in
                    guard error == nil else {
                        self.user = UserModel(
                            id: id,
                            userName: userName,
                            image: image,
                            likes: 0,
                            dislikes: 0,
                            description: description,
                            isAdmin: isAdmin,
                            opinions: []
                        )
                        return
                    }
                    
                    image = data
                    
                    self.user = UserModel(
                        id: id,
                        userName: userName,
                        image: image,
                        likes: 0,
                        dislikes: 0,
                        description: description,
                        isAdmin: isAdmin,
                        opinions: []
                    )
                }
                
                print(self.user)
            }
        }
    }
    
    func sendDataToDB(user: UserModel) {
        guard let id = auth.currentUser?.uid else {
            return
        }
        
        let path = db.child("user").child(id)
        let imageId = Int64().currentTimeMillis()
        
        if user.image != nil && user.image != self.user?.image {
            db.child("user").child(id).child("image").getData { error, snapshot in
                guard error == nil else {
                    return
                }
                
                let imageId = snapshot?.value as? Int ?? 0
                print(imageId)
                
                self.storage.child("image").child("\(imageId).jpg").delete { error in
                    guard error == nil else {
                        print(error)
                        return
                    }
                }
            }
            
            if let image = user.image {
                storage.child("image").child("\(imageId).jpg").putData(image) { (metadata, error) in
                    guard let metadata = metadata else {
                        return
                    }
                    
                    path.child("image").setValue(imageId)
                }
            }
        }
        
        path.child("username").setValue(user.userName)
        path.child("description").setValue(user.description)
        path.child("isAdmin").setValue(user.isAdmin)
        
        self.user = user
    }
}
