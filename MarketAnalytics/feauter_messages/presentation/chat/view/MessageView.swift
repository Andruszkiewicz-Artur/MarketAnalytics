//
//  MessageView.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 11/02/2023.
//

import SwiftUI
import FirebaseDatabase

struct MessageView: View {
    
    let message: String
    let isYours: Bool
    let isGroup: Bool
    let username: String
    
    init(message: String, isYours: Bool, isGroup: Bool, username: String) {
        self.message = message
        self.isYours = isYours
        self.isGroup = isGroup
        self.username = username
    }
    
    var body: some View {
        if isYours {
            VStack {
                if isGroup {
                    HStack {
                        Spacer()
                        Text("You")
                            .foregroundColor(.theme.accent)
                    }
                }
                HStack {
                    Spacer()
                    HStack {
                        Text(message)
                            .padding()
                            .foregroundColor(.white)
                    }
                    .background(Color.theme.secondaryAccent)
                    .cornerRadius(20)
                    .padding([.leading], 20)
                }
            }
        } else {
            VStack {
                if isGroup {
                    HStack {
                        Text(username)
                            .foregroundColor(.primary)
                        Spacer()
                    }
                }
                HStack {
                    VStack {
                        Text(message)
                            .padding()
                            .foregroundColor(.white)
                    }
                    .background(.gray)
                    .cornerRadius(20)
                    .padding([.trailing], 20)
                    
                    Spacer()
                }
            }
        }
    }
}
