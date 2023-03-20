//
//  ChangePasswordView.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 23/11/2022.
//

import SwiftUI

struct ChangePasswordView: View {
    
    @EnvironmentObject private var vmApp: AppViewModel
    @StateObject private var vm: ChangePasswordViewModel = ChangePasswordViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            BottomBorderTextField(hint: "New password...",isSecure: true , value: $vm.password)
            BottomBorderTextField(hint: "Re-password...",isSecure: true, value: $vm.rePassword)
                .padding(.bottom)
            
            CustomTextView(title: "Save")
                .padding(.vertical)
                .onTapGesture(count: 1) {
                    switch vm.resetPassword(vm: vmApp) {
                    case .success: do {
                        dismiss()
                    }
                    case .error: do {  }
                    }
                }
            Spacer()
        }
        .padding()
        .navigationTitle("Change password")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $vm.presentAlert) {
            Alert(
                title: Text("Error"),
                message: Text(vm.presentMessage),
                dismissButton: .cancel(Text("Ok"))
            )
        }
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
