//
//  OpinionsProfileView.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 23/11/2022.
//

import SwiftUI

struct OpinionsProfileView: View {
    
    let opinions: [OpinionModel]
    
    init(opinions: [OpinionModel]) {
        self.opinions = opinions
    }
    
    var body: some View {
        VStack {
            Text("Opinions")
                .font(.title)
            
            if opinions.isEmpty {
                Text("None opinion right now!")
                    .foregroundColor(.gray)
            } else {
                
            }
        }
    }
}

struct OpinionsProfileView_Previews: PreviewProvider {
    static var previews: some View {
        OpinionsProfileView(opinions: [])
    }
}
