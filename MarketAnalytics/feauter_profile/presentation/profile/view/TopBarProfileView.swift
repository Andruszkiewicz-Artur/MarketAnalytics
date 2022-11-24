//
//  TopBarProfileView.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 23/11/2022.
//

import SwiftUI


struct TopBarProfileView: View {
    
    let user: UserModel
    
    init(user: UserModel) {
        self.user = user
    }
    
    var body: some View {
        HStack {
            if let image = user.image {
                Image(uiImage: UIImage(data: image) ?? UIImage())
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(.primary, lineWidth: 2))
            } else {
                ZStack {
                    Circle()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.theme.accent)
                    Text(user.userName.prefix(2).uppercased())
                        .font(.title)
                        .foregroundColor(.white)
                }
            }
            
            VStack {
                HStack {
                    Spacer()
                    LikeProfileView(type: .like, count: user.likes)
                        .padding([.trailing])
                    LikeProfileView(type: .disLike, count: user.dislikes)
                    Spacer()
                }
            }
        }
    }
}

struct TopBarProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
