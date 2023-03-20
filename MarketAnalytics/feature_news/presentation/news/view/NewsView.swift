//
//  NewsView.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 16/11/2022.
//

import SwiftUI

struct NewsView: View {
    @EnvironmentObject private var vmNavigation: NavigationViewModel

    var body: some View {
        VStack {
            
        }
        .onAppear {
            vmNavigation.selectionTab = 1
        }
        .toolbar {
            if vmNavigation.selectionTab == 1 {
                ToolbarItem(placement: .principal) {
                    Text("News")
                }
            }
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
