//
//  ChooseOptionView.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 17/11/2022.
//

import SwiftUI

struct ChooseOptionView: View {
    
    @EnvironmentObject private var vmNavigation: NavigationViewModel
    
    var body: some View {
        NavigationStack(path: $vmNavigation.loginPath) {
            VStack {
                Text("Market Analytics")
                    .font(.largeTitle)
                    .padding([.bottom])
                
                Text("“It doesn't matter if you predicted the rain. What matters is whether you have built the ark. Noah did not wait with the construction of the ark until it rained”")
                    .multilineTextAlignment(.center)
                
                HStack {
                    Spacer()
                    Text("-Warren Buffett-")
                        .fontWeight(.semibold)
                }
                
                Group {
                    NavigationLink(value: "Login") {
                        CustomTextView(title: "Login")
                    }
                    
                    HStack {
                        VStack { Divider() }
                        
                        Text("OR")
                            .font(.title3)
                            .padding([.leading, .trailing])
                        
                        VStack { Divider() }
                    }
                    
                    NavigationLink(value: "Register") {
                        CustomTextView(title: "Sign up", isBorder: true)
                    }
                }
                .padding([.top])
            }
            .padding()
        }
    }
}

struct ChooseOptionView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseOptionView()
    }
}
