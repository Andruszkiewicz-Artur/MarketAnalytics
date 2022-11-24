//
//  LikeProfileView.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 23/11/2022.
//

import SwiftUI

struct LikeProfileView: View {
    
    let type: LikeTypeEnum
    let count: Int
    
    init(type: LikeTypeEnum, count: Int) {
        self.type = type
        self.count = count
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: type == LikeTypeEnum.like ? "hand.thumbsup" : "hand.thumbsdown")
                Text("\(count)")
            }
            .font(.title)
            .padding([.bottom], 5)
            
            Text(type == LikeTypeEnum.like ? "Likes" : "Dislikes")
                .font(.title3)
        }
    }
}

struct LikeProfileView_Previews: PreviewProvider {
    static var previews: some View {
        LikeProfileView(type: .like, count: 10)
    }
}
