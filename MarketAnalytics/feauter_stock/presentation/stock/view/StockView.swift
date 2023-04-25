//
//  StockView.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 16/11/2022.
//

import SwiftUI

struct StockView: View {
    @EnvironmentObject private var vmApp: AppViewModel
    @EnvironmentObject private var vmNavigation: NavigationViewModel
    @StateObject private var vm: StockViewModel = StockViewModel()
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false ,content: {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Forex")
                            .foregroundColor(vm.whichTypeCurrency == .Forex ? Color.theme.accent : Color.primary)
                            .onTapGesture {
                                vm.whichTypeCurrency = .Forex
                            }
                            .font(.title2)
                            
                        if vm.whichTypeCurrency == .Forex {
                            LineView()
                        }
                    }
                    .padding([.trailing], 20)
                    
                    VStack(alignment: .leading) {
                        Text("Crypto")
                            .foregroundColor(vm.whichTypeCurrency == .Crypto ? Color.theme.accent : Color.primary)
                            .onTapGesture {
                                vm.whichTypeCurrency = .Crypto
                            }
                            .font(.title2)
                        
                        if vm.whichTypeCurrency == .Crypto {
                            LineView()
                        }
                    }
                }
            })
            .padding(.horizontal)
            .frame(height: 70)
            
            NavigationLink(value: vm.chatType) {
                liveChatView()
            }
            
            if vm.stockList.isEmpty {
                Text("Non assets!")
                Spacer()
            } else {
                VStack {
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(vm.stockList, id: \.self) { asset in
                            NavigationLink(value: asset) {
                                SingleAssetView(asset: asset)
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .padding([.bottom], 5)
            }
        }
        .onAppear {
            vmNavigation.selectionTab = 0
        }
        .toolbar {
            if vmNavigation.selectionTab == 0 {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(value: "Chats") {
                        Image(systemName: "paperplane")
                            .foregroundColor(.primary)                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("Market Analitics")
                        .font(.title)
                }
            }
        }
        .navigationDestination(for: String.self) { string in
            switch string {
                case "Chats": do {
                    ChatsView()
                }
                case "CreateEditGroupView": do {
                    CreateEditChatView(createGroup: true)
                }
                case "EditProfile": do {
                    EditProfileView()
                }
                case "ChangePasswordProfile": do {
                    ChangePasswordView()
                }
                case "ChangeEmailProfile": do {
                    ChangeEmailView()
                }
                default: do {  }
            }
        }
        .navigationDestination(for: CurrencyModel.self, destination: { currency in
            ShareView(currency: currency)
        })
        .searchable(text: $vm.searchValue)
        .navigationDestination(for: ChatModel.self) { chat in
            ChatView(chat: chat, user: nil)
        }
    }
}

struct StockView_Previews: PreviewProvider {
    static var previews: some View {
        StockView()
    }
}
