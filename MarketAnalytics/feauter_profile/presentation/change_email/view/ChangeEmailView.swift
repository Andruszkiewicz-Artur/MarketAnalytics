//
//  ChangeEmailView.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 24/11/2022.
//

import SwiftUI

struct ChangeEmailView: View {
    
    @EnvironmentObject private var vmApp: AppViewModel
    @StateObject private var vm: ChangeEmailViewModel = ChangeEmailViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            TextField("Email...", text: $vm.email)
                .padding(.vertical)
            
            CustomTextView(title: "Change Email")
                .onTapGesture(count: 1) {
                    switch vm.changeEmail(vm: vmApp) {
                        case.success: do {
                            dismiss()
                        }
                        case .error: do {  }
                    }
                }
                .padding(.vertical)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Change Email")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $vm.presentAlert) {
            Alert(
                title: Text("Error"),
                message: Text(vm.errorMessage),
                dismissButton: .cancel(Text("Ok"))
            )
        }
        .onAppear {
            vm.email = vmApp.auth.currentUser?.email ?? ""
        }
    }
}

struct ChangeEmailView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeEmailView()
    }
}
