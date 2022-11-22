//
//  NavigationLink.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 17/11/2022.
//

import Foundation
import SwiftUI

extension Text {
    
    func customNavigationLink(title: String) {
        Text(title)
            .foregroundColor(Color.white)
            .background(LinearGradient(colors: [Color.theme.accent, Color.theme.secondaryAccent], startPoint: .trailing, endPoint: .leading))
    }
    
    func customBorderNavigationLink() {
        
    }
}
