//
//  SignupView.swift
//  NotesApp
//
//  Created by MNouman on 31/08/2025.
//

import SwiftUI

struct SignupView: View {
    
    let onSignInTap: () -> Void
    @Environment(\.dismiss) private var dismiss
    
    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    var body: some View {
        ZStack{
            Color.blue.opacity(0.2)
            VStack{
                VStack(alignment: .leading){
                    Header:do {
                        VStack(alignment:.center,spacing: 6){
                            Image(systemName: "folder")
                                .font(Font.system(size: 50, weight: .regular))
                                .foregroundStyle(.blue)
                            Text("Create Account")
                                .font(.headline)
                            Text("Sign up for your NotesApp account")
                                .font(.subheadline)
                            
                        }
                        .padding(.bottom,12)
                        .frame(maxWidth: .infinity)
                    }
                    CustomTextView(isSecure: false,placeHolder: "Enter your Full Name",imageName: "person.fill", title: "Full Name",userInput: $fullName)
                    CustomTextView(isSecure: false,placeHolder: "Enter your Email",imageName: "envelope", title: "Email",userInput: $email)
                    CustomTextView(isSecure: true,placeHolder: "Create a password",imageName: "lock",title: "Password",userInput: $password)
                    CustomTextView(isSecure: true,placeHolder: "Confirm your password",imageName: "lock",title: "Cofirm Password",userInput: $confirmPassword)
                    
                    Button(action: {
                        
                    }) {
                        Text("Sign Up")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.black)
                    .padding(.top,12)
                    
                    HStack(spacing:1){
                        Text("Already have an account?")
                            .foregroundStyle(.secondary)
                            .font(Font.system(size: 12))
                        Button(action: {
                            dismiss()
                        }) {
                            Text("Sign In here")
                                .font(Font.system(size: 12))
                                .foregroundStyle(.black)
                        }
                    }
                    .padding(.vertical,8)
                    .frame(maxWidth:.infinity)
                    
                    
                }
                .padding(.all,30)
                .frame(maxWidth: .infinity,alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .padding()
                )
            }
            .frame(maxWidth: .infinity,maxHeight: 300)
            
            
        }
        .ignoresSafeArea(.all)
        .navigationBarBackButtonHidden(true) // extra safety
    }
    private func navigateToSignIn(){
      

    }
}

#Preview {
    let onSignInTap: () -> Void = {}
    SignupView(onSignInTap: onSignInTap)
}
