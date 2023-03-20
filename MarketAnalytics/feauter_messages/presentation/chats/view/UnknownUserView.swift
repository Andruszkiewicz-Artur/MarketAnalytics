//
//  CircleWithLetterView.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 10/02/2023.
//

import SwiftUI

struct UnknownUserView: View {
    
    var username: String
    var isLast: Bool
    
    var body: some View {
        VStack {
            HStack {
                ZStack(alignment: .center) {
                    Circle()
                        .foregroundColor(.theme.accent)
                        .frame(width: 50, height: 50)
                    
                    Text(username.uppercased().prefix(2))
                        .foregroundColor(.white)
                        .font(.title)
                }
                .padding([.trailing], 10)
                
                Text(username)
                    .font(.title2)
                
                Spacer()
            }
            
            if isLast {
                Divider()
            }
        }
    }
}
