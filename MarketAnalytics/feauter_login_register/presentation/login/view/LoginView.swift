//
//  LoginView.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 16/11/2022.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var vm: LoginViewModel = LoginViewModel()
    @EnvironmentObject private var vmApp: AppViewModel
    @EnvironmentObject private var vmNavigation: NavigationViewModel
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        NavigationStack(path: $vmNavigation.loginPath){
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
                    
                    HStack {
                        Spacer()
                        
                        NavigationLink(value: "Forget") {
                            Text("Forget password?")
                                .fontWeight(.semibold)
                                .foregroundColor(Color.primary)
                        }
                    }
                }
                
                Group {
                    CustomTextView(title: "Login")
                        .onTapGesture(count: 1) {
                            vm.logIn(vm: vmApp, vmNavigation: vmNavigation) { isLogIn in
                                if isLogIn {
                                    presentationMode.wrappedValue.dismiss()
                                    print("Logout from login")
                                }
                                
                            }
                        }
                        .padding([.top], 40)
                    
                    HStack {
                        Text("Don`t have an account?")
                        
                        NavigationLink(value: "Register") {
                            Text("Sign up")
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
                    dismissButton: .cancel(Text("OK"), action: {
                        vm.hideError()
                    })
                )
            }
            .navigationDestination(for: String.self) { string in
                switch string {
                case "Login": do {
                    LoginView()
                }
                case "Register": do {
                    RegistrationView()
                }
                case "Forget": do {
                    ForgetPasswordView()
                }
                default: do {}
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
