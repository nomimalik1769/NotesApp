//
//  LoginView.swift
//  NotesApp
//
//  Created by MNouman on 30/08/2025.
//

import SwiftUI
import SwiftData

struct LoginView: View {
    
    let onSignupTap: () -> Void
    let onHomeTap: () -> Void?
    
    @Environment(\.modelContext) var modelContext
    @StateObject var defaults = DefaultsManager.shared
    
    @State private var email = ""
    @State private var password = ""
    @State private var emailError:String? = nil
    @State private var passwordError:String? = nil
    @State private var showErrorAlert: Bool = false
    
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
                            Text("Welcome Back")
                                .font(.headline)
                            Text("Sign in to your NotesApp account")
                                .font(.subheadline)
                            
                        }
                        .padding(.bottom,12)
                        .frame(maxWidth: .infinity)
                    }
                    CustomTextView(isSecure: false,placeHolder: "Enter your email",imageName: "envelope", title: "Email",userInput: $email,errorMessage: emailError)
                        
                        
                    CustomTextView(isSecure: true,placeHolder: "Enter your password",imageName: "lock",title: "Password",userInput: $password,errorMessage: passwordError).textContentType(.password)
                    
                    Button(action: {
                        validate()
                    }) {
                        Text("Sign In")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.black)
                    .padding(.top,12)
                    
                    HStack(spacing:1){
                        Text("Don't have an account?")
                            .foregroundStyle(.secondary)
                            .font(Font.system(size: 12))
                        Button(action: {
                            onSignupTap()
                        }) {
                            Text("Sign Up here")
                                .font(Font.system(size: 12))
                                .foregroundStyle(.black)
                        }
                    }
                    .padding(.vertical,8)
                    .frame(maxWidth:.infinity)
                    
                    VStack(alignment:.leading,spacing: 1){
                        Text("Demo Account:")
                            .foregroundStyle(.blue)
                            .font(.headline)
                            .bold()
                        Text("Email: demo@example.com")
                            .font(.caption)
                            .foregroundStyle(Color.blue)
                        Text("Password: demo123")
                            .font(.caption)
                            .foregroundStyle(Color.blue)
                        
                    }
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.all,10)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.blue.opacity(0.45))
                    )
                    
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
            .onChange(of: email) { (oldValue,newValue) in
                if !newValue.isEmpty && oldValue != newValue {
                    emailError = nil
                }
            }
            .onChange(of: password) { (oldValue,newValue) in
                if !newValue.isEmpty && oldValue != newValue {
                    passwordError = nil
                }
            }
            .alert("Error",
                   isPresented: $showErrorAlert,
                   actions: {
                Button("OK", role: .cancel) { }
            },
                   message: {
                Text("Invalid username and password")
            })
            
            
        }
        .ignoresSafeArea(.all)
        
    }
    private func validate() {
        emailError = email.isEmpty ? "Email is required" : nil
        passwordError = password.isEmpty ? "Password is required" : nil
        
        if emailError == nil, passwordError == nil {
            if let user = checkIfUserExist(){
                defaults.isLoggedIn = true
                defaults.profile = user.dto
                onHomeTap()
            }else{
                showErrorAlert = true
            }
        }
     }
    
    private func checkIfUserExist() -> UserModel?{
        let predicate = #Predicate<UserModel>{$0.email == email && $0.password == password}
        let descriptor = FetchDescriptor(predicate: predicate)
        let getData = try? modelContext.fetch(descriptor)
        return (getData?.first)
        
    }
 
}

#Preview {
    let onSignupTap: () -> Void = {}
    LoginView(onSignupTap: onSignupTap,onHomeTap: {})
}
