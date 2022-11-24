//
//  EditProfileViewModel.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 24/11/2022.
//

import Foundation
import PhotosUI
import _PhotosUI_SwiftUI

class EditProfileViewModel: ObservableObject {
    
    @Published var user: UserModel = UserModel(
        id: "",
        userName: "",
        image: nil,
        likes: 0,
        dislikes: 0,
        description: "",
        isAdmin: false,
        opinions: []
    )
    
    @Published var photos: [PhotosPickerItem] = []
    
    func saveData(vm: AppViewModel) {
        if !user.userName.isEmpty {
            vm.sendDataToDB(user: user)
        }
    }
}
