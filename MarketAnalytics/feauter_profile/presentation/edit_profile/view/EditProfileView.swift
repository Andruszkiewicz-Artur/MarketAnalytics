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
    @EnvironmentObject private var vmNavigation: NavigationViewModel
    @StateObject private var vm: EditProfileViewModel = EditProfileViewModel()
    @Environment(\.dismiss) private var dismiss
    private let width = UIScreen.main.bounds.width
    
    var body: some View {
        VStack {
            BottomBorderTextField(hint: "Username...", isSecure: false, value: $vm.user.userName)
            
            CustomTextView(title: "Save")
                .onTapGesture {
                    vm.saveData(vm: vmApp)
                }
            
            CustomTextView(title: "Remove Account", isBorder: true)
                .onTapGesture {
                    vm.isPresentedRemoveAccount = true
                }
            Spacer()
        }
        .padding(.horizontal)
        .onAppear {
            if let user = vmApp.user {
                vm.user = user
            }
        }
        .confirmationDialog("Are you sure to remove your account", isPresented: $vm.isPresentedRemoveAccount) {
            Button("Remove Account") {
                vm.removeAccount(vm: vmApp) { isDeleted in
                    if isDeleted == true {
                        dismiss()
                    }
                }
            }
        }
        .navigationTitle("Edit profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
