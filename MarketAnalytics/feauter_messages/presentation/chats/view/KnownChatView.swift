//
//  KnownChatView.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 11/02/2023.
//

import SwiftUI

struct KnownChatView: View {
    
    let name: String
    let lastMessage: String
    let isLast: Bool
    
    init(name: String, lastMessage: String, isLast: Bool) {
        self.name = name
        self.lastMessage = lastMessage
        self.isLast = isLast
        
        print(lastMessage)
    }
    
    var body: some View {
        VStack {
            HStack {
                ZStack(alignment: .center) {
                    Circle()
                        .foregroundColor(.theme.accent)
                        .frame(width: 50, height: 50)
                    
                    Text(name.uppercased().prefix(2))
                        .foregroundColor(.white)
                        .font(.title)
                        .lineLimit(1)
                }
                .padding([.trailing], 10)
                
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.title2)
                    
                    if lastMessage != "" {
                        Text(lastMessage)
                            .font(.title3)
                            .lineLimit(1)
                    } else {
                        Text("Non message yet!")
                            .font(.title3)
                            .lineLimit(1)
                    }
                }
                
                Spacer()
            }
            
            if isLast {
                Divider()
            }
        }
    }
}
