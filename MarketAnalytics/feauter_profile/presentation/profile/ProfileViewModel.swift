//
//  ProfileViewModel.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 22/11/2022.
//

import Foundation

class ProfileViewModel: ObservableObject {
    
    @Published var user = UserModel(id: "", userName: "", likes: 0, dislikes: 0, description: "", isAdmin: false, opinions: [])
    
}
