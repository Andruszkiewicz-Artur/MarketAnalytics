//
//  EditProfileView.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 23/11/2022.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    
    @EnvironmentObject private var vmApp: AppViewModel
    @StateObject private var vm: EditProfileViewModel = EditProfileViewModel()
    private let width = UIScreen.main.bounds.width
    
    var body: some View {
        VStack {
            if let user = vmApp.user {
                PhotosPicker(
                    selection: $vm.photos,
                    maxSelectionCount: 1,
                    matching: .images
                ) {
                    if let image = vm.user.image {
                        Image(uiImage: UIImage(data: image) ?? UIImage())
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: width/2, height: width/2)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(.primary, lineWidth: 2))
                    } else {
                        ZStack {
                            Circle()
                                .frame(width: width/2, height: width/2)
                                .foregroundColor(.gray)
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: width/3, height: width/3)
                                .foregroundColor(.white)
                        }
                    }
                }
                
                TextField("User name...", text: $vm.user.userName)
                    .padding(.vertical)
                TextField("Description...", text: $vm.user.description, axis: .vertical)
                
                Spacer()
            }
        }
        .padding(.horizontal)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    vm.saveData(vm: vmApp)
                }
            }
        }
        .onAppear {
            if let user = vmApp.user {
                vm.user = user
            }
        }
        .onChange(of: vm.photos) { newValue in
            guard let item = vm.photos.first else {
                return
            }
            
            item.loadTransferable(type: Data.self) { result in
                switch result {
                case .success(let data):
                    if let data = data {
                        vm.user.image = data
                    } else {
                        print("Data is nil")
                    }
                case .failure(let failure):
                    fatalError(failure.localizedDescription)
                }
            }
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
