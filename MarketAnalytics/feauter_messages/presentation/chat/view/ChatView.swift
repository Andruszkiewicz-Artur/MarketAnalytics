//
//  ChatView.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 10/02/2023.
//

import SwiftUI
import FirebaseAuth

struct ChatView: View {
    
    @StateObject private var vm: ChatViewModel = ChatViewModel()
    @Environment(\.dismiss) private var dismiss
    
    private let user: UserModel?
    private let chat: ChatModel?
    private let title: String
    private let idUser: String
    
    init(chat: ChatModel?, user: UserModel?) {
        self.user = user
        self.chat = chat
        
        idUser = Auth.auth().currentUser?.uid ?? ""
        
        if chat != nil {
            title = chat!.name
        } else {
            title = user!.userName
        }
    }
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView() {
                    VStack {
                        ForEach(vm.messages, id: \.self) { message in
                            MessageView(message: message.message, isYours: message.idUser == idUser, isGroup: chat?.isGroup ?? false, username: message.username ?? "")
                                .rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center)
                        }
                    }
                }
                .rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center)
                
                HStack {
                    WriteTextField(value: $vm.message)
                    Image(systemName: "paperplane.fill")
                        .onTapGesture {
                            vm.sendMessage()
                        }
                        .font(.title)
                }
            }
            
            .padding()
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            vm.setUp(idUser: user?.id, idChat: chat?.id)
            
            if chat != nil {
                vm.isDeleted(idGroup: chat!.id) { isDeleted in
                    if isDeleted {
                        dismiss()
                    }
                }
            }
        }
        .toolbar {
            if let adminId = chat?.adminId, let userId = Auth.auth().currentUser?.uid {
                if adminId == userId {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink {
                            CreateEditChatView(createGroup: false, idGroup: chat?.id)
                        } label: {
                            Image(systemName: "gearshape.fill")
                        }

                    }
                }
            }
        }
    }
}
