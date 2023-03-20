//
//  ChatsView.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 09/02/2023.
//

import SwiftUI

struct ChatsView: View {
    
    @StateObject private var vm: ChatsViewModel = ChatsViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            if vm.usersList.isEmpty && vm.ChatsList.isEmpty {
                Text("List is Empty")
            } else {
                ForEach(vm.ChatsList, id: \.self) { chat in
                    NavigationLink(value: chat) {
                        KnownChatView(
                            name: chat.name,
                            lastMessage: chat.lastMessage,
                            isLast: vm.ChatsList.last!.name != chat.name
                        )
                    }
                }
                .padding(.horizontal)
                
                ForEach(vm.usersList, id: \.self) { user in
                    NavigationLink(value: user) {
                        UnknownUserView(
                            username: user.userName,
                            isLast: vm.usersList.last!.userName != user.userName
                        )
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
        }
        .navigationTitle("Chats")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(value: "CreateEditGroupView") {
                        Image(systemName: "plus")
                }
            }
        }
        .searchable(text: $vm.searchValue)
        .navigationDestination(for: UserModel.self) { user in
            ChatView(chat: nil, user: user)
        }
//        .navigationDestination(for: ChatModel.self) { chat in
//            ChatView(chat: chat, user: nil)
//        }
        .onAppear {
            vm.getData()
        }
    }
}
