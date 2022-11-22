//
//  Navigation.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 17/11/2022.
//

import Foundation
import SwiftUI

class NavigationViewModel: ObservableObject {
    
    var path = NavigationPath() {
        didSet {
            print("path count: \(path.count)")
        }
    }
    
    func backTooRoot() {
        path = NavigationPath()
    }
}
