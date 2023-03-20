//
//  SwiftUIView.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 10/02/2023.
//

import SwiftUI

struct WriteTextField: View {
    
    @Binding var value: String
    
    var body: some View {
        TextField("Write message...", text: $value, axis: .vertical)
            .padding()
            .background(.gray.opacity(0.1))
            .cornerRadius(20)
            .frame(maxHeight: 100)
    }
}
