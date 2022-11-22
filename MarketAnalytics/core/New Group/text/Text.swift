//
//  Text.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 17/11/2022.
//

import Foundation
import SwiftUI

struct CustomTextView: View {
    
    let title: String
    let isBorder: Bool
    
    private let clear = LinearGradient(colors: [Color.clear], startPoint: .leading, endPoint: .trailing)
    private let color = LinearGradient(colors: [Color.theme.accent, Color.theme.secondaryAccent], startPoint: .leading, endPoint: .trailing)
    
    init(title: String, isBorder: Bool = false) {
        self.title = title
        self.isBorder = isBorder
    }
    
    var body: some View {
        HStack {
            Spacer()
            
            Text(title)
                .font(.title3)
                .padding()
            
            Spacer()
        }
        .background(
            RoundedRectangle(cornerRadius: 100, style: .continuous).fill(isBorder ? clear : color)
        )
        .foregroundColor(isBorder ? Color.primary : Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(isBorder ? color : clear, lineWidth: 3)
        )
    }
    
}
