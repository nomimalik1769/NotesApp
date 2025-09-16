//
//  SignupView.swift
//  NotesApp
//
//  Created by MNouman on 31/08/2025.
//

import SwiftUI
import SwiftData

struct SignupView: View {
    
    let onSignInTap: () -> Void
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    @State private var fullNameError: String?
    @State private var emailError: String?
    @State private var passwordError: String?
    
    @State private var showErrorMessage:Bool = false
    @State private var errorMessage:String = ""
    
    @State private var successAlertShow:Bool = false
    
    
    
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
                    CustomTextView(isSecure: false,placeHolder: "Enter your Full Name",imageName: "person.fill", title: "Full Name",userInput: $fullName,errorMessage: fullNameError)
                    CustomTextView(isSecure: false,placeHolder: "Enter your Email",imageName: "envelope", title: "Email",userInput: $email,errorMessage: emailError)
                    CustomTextView(isSecure: true,placeHolder: "Create a password",imageName: "lock",title: "Password",userInput: $password,errorMessage: passwordError)
                    CustomTextView(isSecure: true,placeHolder: "Confirm your password",imageName: "lock",title: "Cofirm Password",userInput: $confirmPassword)
                    
                    Button(action: {
                        validateAndRegister()
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
        .alert(isPresented: $showErrorMessage) {
            Alert(
                title: Text("Error"),
                message: Text(errorMessage),
                dismissButton: .cancel()
            )
        }
        .alert(isPresented: $successAlertShow) {
            Alert(
                title: Text("Success"),
                message: Text("You account has been created successfully"),
                dismissButton: .default(Text("Login"), action: {
                    dismiss()
                })
            )
        }
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
        .onChange(of: fullName) { (oldValue,newValue) in
            if !newValue.isEmpty && oldValue != newValue {
                fullNameError = nil
            }
        }
        
        
    }
    private func validateAndRegister(){
        if fullName.isEmpty{
            fullNameError = "Full Name is required"
        }else if email.isEmpty{
            emailError = "Email is required"
        }
        else if password.isEmpty{
            passwordError = "Password is required"
        }
        else if password != confirmPassword{
            passwordError = "Passwords do not match"
        }else{
            if checkEmailExist(){
                errorMessage = "Email already exist"
                showErrorMessage = true
            }else{
                let userModel : UserModel = .init(email: email, name: fullName, password: password)
                modelContext.insert(userModel)
                successAlertShow = true
            }
        }
    }
    private func checkEmailExist() -> Bool{
        let predicate = #Predicate<UserModel>{$0.email == email}
        let descriptor = FetchDescriptor<UserModel>(predicate: predicate)
        return (try? modelContext.fetch(descriptor).isEmpty == false) ?? false
    }
    private func navigateToSignIn(){
      

    }
}

#Preview {
    let onSignInTap: () -> Void = {}
    SignupView(onSignInTap: onSignInTap)
}
