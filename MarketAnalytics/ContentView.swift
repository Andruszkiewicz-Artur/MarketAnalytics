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
                    .tag(0)
                ProfileView()
                    .tabItem {
                        Image(systemName: "person")
                        Text("Profile")
                    }
                    .tag(1)
            }
            .accentColor(Color.theme.accent)
        }
        .accentColor(Color.primary)
        .fullScreenCover(isPresented: $vmApp.presentLogIn) {
            LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
