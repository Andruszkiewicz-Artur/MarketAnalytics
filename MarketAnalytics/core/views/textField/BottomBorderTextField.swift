//
//  BottomBorderTextField.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 08/02/2023.
//

import SwiftUI

struct BottomBorderTextField: View {
    
    var hint: String
    var isSecure: Bool
    @Binding var value: String
    
    var body: some View {
        HStack(alignment: .center) {
            if isSecure {
                SecureField(hint, text: $value)
                    .font(.title3)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
            } else {
                TextField(hint, text: $value)
                    .font(.title3)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
            }
        }
        .overlay(Divider().background(Color.theme.accent), alignment: .bottom)
        .padding(.vertical)
    }
}
