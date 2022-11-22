//
//  ProfileView.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 16/11/2022.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack {
            Text("Profile")
        }
        .padding([.leading, .trailing])
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("User Name")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(value: "Settings") {
                    Image(systemName: "gearshape")
                        .foregroundColor(Color.primary)
                }
            }
        }
        .navigationDestination(for: String.self) { string in
            switch string {
            case "Settings": do {
                SettingsView()
            }
            default: do {  }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
