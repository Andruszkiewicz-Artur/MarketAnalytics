//
//  DescriptionProfileView.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 23/11/2022.
//

import SwiftUI

struct DescriptionProfileView: View {
    
    let description: String?
    
    init(description: String?) {
        self.description = description
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Description")
                .font(.title)
                .padding(.vertical)
            Text(description ?? "Description is empty")
                .padding(.bottom)
            
            Divider()
                .frame(height: 1)
                .overlay(Color.theme.accent)
        }
    }
}

struct DescriptionProfileView_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionProfileView(description: nil)
    }
}
