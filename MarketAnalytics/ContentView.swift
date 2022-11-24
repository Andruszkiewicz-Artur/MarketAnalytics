//
//  ContentView.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 16/11/2022.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var vmApp: AppViewModel
    @EnvironmentObject var vmNavigation: NavigationViewModel
    
    var body: some View {
        NavigationStack(path: $vmNavigation.path) {
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
            .fullScreenCover(isPresented: $vmApp.isSignedIn) {
                ChooseOptionView()
            }
        }
        .accentColor(Color.primary)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
