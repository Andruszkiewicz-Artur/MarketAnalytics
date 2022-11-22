//
//  NavigationLink.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 17/11/2022.
//

import Foundation
import SwiftUI

class customNavigationLink {
    
    struct CusNavLink<Label: View, Destination: View>: View {

        let destination: Destination
        let label : Label

        init(destination: Destination, @ViewBuilder label: () -> Label) {
            self.destination = destination
            self.label = label()
        }

        var body: some View {
            NavigationLink(
                destination: CusNavContainer {
                    destination
                }
                label: {
                    label
            })
        }
    }
}
