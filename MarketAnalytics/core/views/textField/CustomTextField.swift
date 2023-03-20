//
//  CustomTextField.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 17/11/2022.
//

import SwiftUI

struct CustomTextField: View {
    
    let systemName: String
    let hint: String
    var isSecure: Bool = false
    @Binding var value: String
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: systemName)
                .padding()
                .font(.system(size: 25))
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
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(LinearGradient(colors: [Color.theme.accent, Color.theme.secondaryAccent], startPoint: .leading, endPoint: .trailing), lineWidth: 3)
        }
        .background(.gray.opacity(0.1))
    }
}
