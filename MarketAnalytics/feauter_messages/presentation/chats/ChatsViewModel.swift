//
//  ChatsViewModel.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 10/02/2023.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class ChatsViewModel: ObservableObject {
    
    private var firstSearch: Bool = true
    @Published var searchValue: String = "" {
        didSet {
            usersList = []
            ChatsList = []
            
            if firstSearch {
                var unknownUsers: [UserModel] = []
                allUsers.forEach { user in
                    var isUnkown = true
                    allChats.forEach { chat in
                        if user.userName == chat.name {
                            isUnkown = false
                        }
                    }
                    
                    if isUnkown {
                        unknownUsers.append(user)
                    }
                }
                
                allUsers = []
                unknownUsers.forEach { user in
                    allUsers.append(user)
                }
                
                firstSearch = false
            }
            
            if !searchValue.isEmpty {
                allUsers.forEach { user in
                    if user.userName.lowercased().contains(searchValue.lowercased()) {
                        usersList.append(user)
                    }
                }
                allChats.forEach { chat in
                    if chat.name.lowercased().contains(searchValue.lowercased()) {
                        ChatsList.append(chat)
                    }
                }
            } else {
                ChatsList = allChats
            }
        }
    }
    
    private var allChats: [ChatModel] = []
    private var allUsers: [UserModel] = []
    @Published var usersList: [UserModel] = []
    @Published var ChatsList: [ChatModel] = []
    
    func getData() {
        allChats = []
        allUsers = []
        usersList = []
        ChatsList = []
        
        let ref = Database.database().reference().child("user")
        guard let id = Auth.auth().currentUser?.uid else {
            return
        }
        ref.getData { error, snapshot in
            guard error == nil, let value = snapshot?.value as? NSDictionary else {
                return
            }
            self.usersList = []
            
            for user in value.allKeys {
                if user as! String != id {
                    Database.database().reference().child("user").child(user as! String).getData { error, snapshot in
                        guard error == nil, let value = snapshot?.value as? NSDictionary else {
                            return
                        }
                        
                        self.allUsers.append(UserModel(id: user as! String, userName: value["username"] as? String ?? "none"))
                    }
                }
            }
        }
        
        ref.child(id).child("chats").getData { error, snapShot in
            guard error == nil, let value = snapShot?.value as? NSDictionary else {
                return
            }
            
            for chat in value.allKeys {
                
                Database.database().reference().child("chat").child(chat as! String).getData { error, snapShot in
                    guard error == nil, let value = snapShot?.value as? NSDictionary, let idChat = snapShot?.key else {
                        return
                    }
                    
                    var lastMessage: String = ""
                    
                    Database.database().reference().child("chat").child(chat as! String).child("lastMessage").getData { error, snapShot in
                        guard error == nil, let message = snapShot?.value as? NSDictionary else {
                            return
                        }
                        
                        lastMessage = message["content"] as? String ?? ""
                        
                        if value["isGroup"] as! Bool == false {
                            for user in value["Users"] as! [String] {
                                if user != id {
                                    Database.database().reference().child("user").child(user).getData { error, snapShot in
                                        guard error == nil, let value = snapShot?.value as? NSDictionary else {
                                            return
                                        }
                                        
                                        self.allChats.append(ChatModel(isGroup: false, name: value["username"] as! String, id: idChat, lastMessage: lastMessage, adminId: nil))
                                        self.ChatsList.append(ChatModel(isGroup: false, name: value["username"] as! String, id: idChat, lastMessage: lastMessage, adminId: nil))
                                    }
                                }
                            }
                        } else {
                            self.allChats.append(ChatModel(isGroup: true, name: value["groupName"] as! String, id: idChat, lastMessage: lastMessage, adminId: value["adminId"] as? String))
                            self.ChatsList.append(ChatModel(isGroup: true, name: value["groupName"] as! String, id: idChat, lastMessage: lastMessage, adminId: value["adminId"] as? String))
                        }
                    }
                }
            }
        }
    }
}
