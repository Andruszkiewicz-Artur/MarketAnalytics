//
//  Navigation.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 17/11/2022.
//

import Foundation
import SwiftUI

class NavigationViewModel: ObservableObject {
    
    @Published var path = NavigationPath()
    @Published var selectionTab: Int = 0
    
    @Published var loginPath = NavigationPath() {
        didSet {
            print("path count: \(path.count)")
        }
    }
    
    func backTooRoot(where back: Option) {
        switch back {
        case .login: loginPath = NavigationPath()
        case .standard: path = NavigationPath()
        }
    }
    
    @Published var chooseOption: Bool = false
    
    enum Option {
        case login
        case standard
    }
}
