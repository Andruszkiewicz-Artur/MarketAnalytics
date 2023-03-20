//
//  RegistrationView.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 16/11/2022.
//

import SwiftUI

struct RegistrationView: View {
    
    @StateObject private var vm: RegistrationViewModel = RegistrationViewModel()
    @EnvironmentObject private var vmApp: AppViewModel
    @EnvironmentObject private var vmNavigation: NavigationViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            
            Text("Market Analytics")
                .font(.largeTitle)
                .padding([.bottom], 40)
            
            
            Group {
                Text("Welcome Back")
                    .font(.title2)
                    .padding(.bottom)
                
                Text("Login to your account")
                    .padding([.bottom], 40)
            }
            
            Group {
                CustomTextField(
                    systemName: "person",
                    hint: "User name...",
                    value: $vm.userName
                )
                .padding(.bottom)
                
                
                CustomTextField(
                    systemName: "envelope",
                    hint: "Email...",
                    value: $vm.email
                )
                .padding(.bottom)
                
                CustomTextField(
                    systemName: "lock",
                    hint: "Password...",
                    isSecure: true,
                    value: $vm.password
                )
                .padding(.bottom)
                
                CustomTextField(
                    systemName: "lock",
                    hint: "Re-Password...",
                    isSecure: true,
                    value: $vm.repassword
                )
            }
            
            Group {
                CustomTextView(title: "Sign up")
                    .onTapGesture(count: 1) {
                        vm.signIn(vm: vmApp, vmNavigation: vmNavigation)
                        if vmApp.presentLogIn == false {
                            dismiss()
                        }
                    }
                    .padding([.top], 40)
                
                HStack {
                    Text("Already have an account?")
                    
                    NavigationLink(value: "Login") {
                        Text("Login")
                            .fontWeight(.semibold)
                            .foregroundColor(Color.primary)
                    }
                }
            }
        }
        .padding()
        .navigationBarHidden(true)
        .alert(isPresented: $vm.presentError) {
            Alert(
                title: Text("Error"),
                message: Text(vm.errorMessage),
                dismissButton: .cancel(Text("Ok"), action: {
                    vm.hideErrorMessage()
                })
            )
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
