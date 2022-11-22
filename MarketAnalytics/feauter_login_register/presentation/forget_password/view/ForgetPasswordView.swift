//
//  ForgetPasswordView.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 16/11/2022.
//

import SwiftUI

struct ForgetPasswordView: View {
    
    @StateObject private var vm: ForgetPasswordViewModel = ForgetPasswordViewModel()
    @EnvironmentObject private var vmApp: AppViewModel
    
    init() {
        print("open forget password")
    }
    
    var body: some View {
        VStack {
            Text("Forget Password?")
                .font(.largeTitle)
                .padding([.bottom])
            
            Text("Enter the email address you use to Login.")
            
            CustomTextField(systemName: "envelope", hint: "Email...", value: $vm.email)
                .padding([.bottom])
                .padding([.top], 80)
            
            CustomTextView(title: "Send message")
                .onTapGesture(count: 1) {
                    vm.sendMessage(vm: vmApp)
                }
        }
        .alert(isPresented: $vm.presentError, content: {
            Alert(
                title: Text(vm.isError ? "Error" : "Success"),
                message: Text(vm.errorMessage),
                dismissButton: .cancel(Text("OK"), action: {
                    vm.hideAlert()
                })
            )
        })
        .padding()
    }
}

struct ForgetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgetPasswordView()
    }
}
