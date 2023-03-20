//
//  CharViewModel.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 10/02/2023.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class ChatViewModel: ObservableObject {
    
    @Published var message: String = ""
    @Published var messages: [MessageModel] = []
    
    private let ref = Database.database().reference()
    
    private var idChat: String? = nil
    private var idUser: String? = nil
    private var selfUID: String = Auth.auth().currentUser!.uid
    
    private func createNewChat() {
        guard let idUser = self.idUser else {
            return
        }
        
        self.idChat = String(DispatchTime.now().uptimeNanoseconds)
        self.ref.child("chat").child(idChat!).child("Users").setValue([idUser, selfUID])
        self.ref.child("chat").child(idChat!).child("isGroup").setValue(false)
        
        self.ref.child("user").child(idUser).child("chats").child(self.idChat!).setValue(false)
        self.ref.child("user").child(selfUID).child("chats").child(self.idChat!).setValue(false)
    }
    
    func sendMessage() {
        if idChat == nil {
            createNewChat()
        }
        
        guard idChat != nil else {
            return
        }
        
        let time = String(DispatchTime.now().uptimeNanoseconds)
        let toTab = ref.child("chat").child(idChat!).child("messages").child(time)
        let toLast = ref.child("chat").child(idChat!).child("lastMessage")
        
        toTab.child("content").setValue(message)
        toTab.child("userId").setValue(selfUID)
        
        toLast.child("userId").setValue(selfUID)
        toLast.child("content").setValue(message)
        
        messages.append(MessageModel(message: message, idUser: selfUID, time: time))
        
        message = ""
        
        self.messages = self.messages.sorted { $0.time > $1.time }
    }
    
    private func takeMessages() {
        if idChat != nil {
            let messagesRef = ref.child("chat").child(idChat!).child("messages")
            
            messagesRef.getData { error, snapShot in
                guard error == nil, let value = snapShot?.value as? NSDictionary else {
                    return
                }
                
                for keyMessage in value.allKeys {
                    messagesRef.child(keyMessage as! String).getData { error, snapShot in
                        guard error == nil, let messageData = snapShot?.value as? NSDictionary else {
                            return
                        }
                        
                        Database.database().reference().child("user").child(messageData["userId"] as! String).getData { error, snapShot in
                            guard error == nil, let value = snapShot?.value as? NSDictionary else {
                                return
                            }
                            
                            self.messages.append(
                                MessageModel(
                                    message: messageData["content"] as! String,
                                    idUser: messageData["userId"] as! String,
                                    username: value["username"] as! String,
                                    time: keyMessage as! String
                                ))
                            
                            self.messages = self.messages.sorted { $0.time > $1.time }
                        }
                    }
                }
            }
        }
    }
    
    func setUp(idUser: String?, idChat: String?) {
        self.idUser = idUser
        self.idChat = idChat
        
        if idChat != nil, messages.isEmpty {
            takeMessages()
        }
    }
    
    func takeNick(idUser: String) -> String {
        var username: String = ""
        
        Database.database().reference().child("user").child(idUser).getData { error, snapShot in
            guard error == nil, let value = snapShot?.value as? NSDictionary else {
                return
            }
            
            username = value["username"] as? String ?? ""
        }
        
        return username
    }
    
    func isDeleted(idGroup: String, complition: @escaping (Bool) -> ()) {
        Database.database().reference().child("chat").child(idGroup).getData { error, snapShot in
            guard error == nil else {
                complition(false)
                return
            }
            guard snapShot != nil else {
                complition(true)
                return
            }
            
            complition(false)
        }
    }
}
