//
//  MarketAnalyticsApp.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 16/11/2022.
//

import SwiftUI
import Firebase

@main
struct MarketAnalyticsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            let vm: AppViewModel = AppViewModel()
            
            ContentView()
                .environmentObject(vm)
        }
    }
}
