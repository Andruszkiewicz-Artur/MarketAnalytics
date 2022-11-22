//
//  SettingsView.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 20/11/2022.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject private var vmApp: AppViewModel
    @EnvironmentObject private var vmNavigation: NavigationViewModel
    @StateObject private var vm: SettingsViewModel = SettingsViewModel()
    
    var body: some View {
        List {
            Section {
                HStack {
                    Spacer()
                    Text("Log Out")
                        .foregroundColor(Color.red)
                        .onTapGesture(count: 1) {
                            vm.logOut(vm: vmApp, vmNavigation: vmNavigation)
                        }
                    Spacer()
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
