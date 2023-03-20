//
//  liveChatView.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 13/03/2023.
//

import SwiftUI

struct liveChatView: View {
    
    var body: some View {
        HStack() {
            Image(systemName: "ellipsis.message")
                .padding([.trailing], 20)
                .padding([.leading, .top, .bottom], 10)
                .font(.system(size: 40))
                .foregroundColor(Color.theme.accent)
            
            
            Text("Live Chat")
                .font(.system(size: 20))
            Spacer()
        }
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.theme.accent, lineWidth: 3)
        )
        .padding(.horizontal)
    }
}

struct liveChatView_Previews: PreviewProvider {
    static var previews: some View {
        liveChatView()
    }
}
