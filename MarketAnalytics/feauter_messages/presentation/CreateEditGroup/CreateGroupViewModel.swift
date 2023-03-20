//
//  CreateGroupViewModel.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 11/02/2023.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class CreateEditChatViewModel: ObservableObject {
    
    private var allUsers: [UserModel] = [] {
        didSet {
            added = []
            addedUsers = []
            notAdded = []
            notAddedUsers = []
            
            allUsers.forEach { user in
                var inGroup = false
                usersInGroup.forEach { userIn in
                    if user.id == userIn {
                        inGroup = true
                    }
                }
                if inGroup {
                    added.append(user)
                    addedUsers.append(user)
                } else {
                    notAdded.append(user)
                    notAddedUsers.append(user)
                }
            }
        }
    }
    private var addedUsers: [UserModel] = []
    private var notAddedUsers: [UserModel] = []
    private var usersInGroup: [String] = []
    
    @Published var groupName: String = ""
    @Published var added: [UserModel] = []
    @Published var notAdded: [UserModel] = []
    @Published var search: String = "" {
        didSet {
            added = []
            notAdded = []
            
            if search != "" {
                addedUsers.forEach { user in
                    if user.userName.lowercased().contains(search.lowercased()) {
                        added.append(user)
                    }
                }
                
                notAddedUsers.forEach { user in
                    if user.userName.lowercased().contains(search.lowercased()) {
                        notAdded.append(user)
                    }
                }
            } else {
                added = addedUsers
                notAdded = notAddedUsers
            }
        }
    }
    
    init() {
        if let ownId = Auth.auth().currentUser?.uid {
            Database.database().reference().child("user").getData { error, snapShot in
                guard error == nil, let value = snapShot?.value as? NSDictionary else {
                    return
                }
                
                for key in value.allKeys {
                    if ownId != key as! String {
                        Database.database().reference().child("user").child(key as! String).getData { error, snapShot in
                            guard error == nil, let value = snapShot?.value as? NSDictionary else {
                                return
                            }
                            
                            self.allUsers.append(UserModel(id: key as! String, userName: value["username"] as! String))
                        }
                    }
                }
            }
        }
    }
    
    func addToGroup(user: UserModel) {
        addedUsers.append(user)
        added.append(user)
        
        var notAddedInner: [UserModel] = []
        
        notAddedUsers.forEach { userInner in
            if user != userInner {
                notAddedInner.append(userInner)
            }
        }
        
        notAddedUsers = notAddedInner
        notAdded = notAddedUsers
        
        self.search = self.search
    }
    
    func removeFromGroup(user: UserModel) {
        notAddedUsers.append(user)
        notAdded.append(user)
        
        var addedInner: [UserModel] = []
        
        addedUsers.forEach { userInner in
            if user != userInner {
                addedInner.append(userInner)
            }
        }
        
        addedUsers = addedInner
        added = addedUsers
        
        self.search = self.search
    }
    
    func createGroup(complition: @escaping (Bool) -> ()) {
        let idGroup = String(DispatchTime.now().uptimeNanoseconds)
        let ref = Database.database().reference().child("chat").child(idGroup)
        
        var addedUsersDuringCreate: [String] = []
        if let userId = Auth.auth().currentUser?.uid, groupName != "" {
            addedUsersDuringCreate.append(userId)
            
            Database.database().reference().child("user").child(userId).child("chats").child(idGroup).setValue(true)
            addedUsers.forEach { user in
                addedUsersDuringCreate.append(user.id)
                Database.database().reference().child("user").child(user.id).child("chats").child(idGroup).setValue(true)
            }
            
            ref.child("Users").setValue(addedUsersDuringCreate)
            ref.child("isGroup").setValue(true)
            ref.child("adminId").setValue(userId)
            ref.child("groupName").setValue(groupName)
            ref.child("lastMessage").child("content").setValue("I create the group")
            ref.child("lastMessage").child("userId").setValue(userId)
            ref.child("lastMessage").child("tiem").setValue(String(DispatchTime.now().uptimeNanoseconds))
            
            return complition(true)
        }
        
        return complition(false)
    }
    
    func loadData(idGroup: String) {
        Database.database().reference().child("chat").child(idGroup).getData { error, snapShot in
            guard error == nil, let groupData = snapShot?.value as? NSDictionary else {
                return
            }
            
            self.groupName = groupData["groupName"] as? String ?? ""
            self.usersInGroup = groupData["Users"] as? [String] ?? []
            
            for user in groupData["Users"] as! [String] {
                print(user)
            }
        }
    }
    
    func saveData(idGroup: String, comlition: @escaping (Bool) -> ()) {
        usersInGroup.forEach { userId in
            Database.database().reference().child("user").child(userId).child("chats").child(idGroup).removeValue()
        }
        
        added.forEach { user in
            Database.database().reference().child("user").child(user.id).child("chats").child(idGroup).setValue(true)
        }
        
        Database.database().reference().child("chat").child(idGroup).child("groupName").setValue(groupName)
        
        var currentUsers: [String] = []
        
        addedUsers.forEach { user in
            currentUsers.append(user.id)
        }
        
        Database.database().reference().child("chat").child(idGroup).child("Users").setValue(currentUsers)
        
        comlition(true)
    }
    
    func removeGroup(idGroup: String, complition: @escaping (Bool) -> ()) {
        addedUsers.forEach { user in
            Database.database().reference().child("user").child(user.id).child("chats").child(idGroup).removeValue()
        }
        
        Database.database().reference().child("chat").child(idGroup).removeValue()
        
        complition(true)
    }
}
