//
//  ContentView.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 16/11/2022.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var vmAuth: AppViewModel
    
    var body: some View {
        if vmAuth.isSignedIn {
            TabView() {
                StockView()
                    .tabItem {
                        Image(systemName: "waveform.path.ecg")
                        Text("Stock")
                    }
                NewsView()
                    .tabItem {
                        Image(systemName: "newspaper")
                        Text("News")
                    }
                ProfileView()
                    .tabItem {
                        Image(systemName: "person")
                        Text("Profile")
                    }
            }
            .accentColor(Color.theme.accent)
        } else {
            LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
