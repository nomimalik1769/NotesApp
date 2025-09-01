//
//  CustomTextView.swift
//  NotesApp
//
//  Created by MNouman on 30/08/2025.
//

import SwiftUI

struct CustomTextView: View {
    let isSecure : Bool
    let placeHolder: String
    let imageName:String
    let title:String

    @Binding var userInput:String
    var errorMessage: String? = nil

    
    var body: some View {
        VStack(alignment: .leading,spacing: 4){
            Text(title)
                .font(.subheadline)
                .bold()
            HStack{
                Image(systemName:imageName).frame(width: 16, height: 16).padding(.leading,8)
                    .foregroundStyle(ThemeManager.white)
                if isSecure{
                    SecureField(text: $userInput) {
                        Text(placeHolder)
                            .foregroundStyle(ThemeManager.white)
                            .font(.system(size: 12))
                    }
                    .frame(height: 35)
                    .font(.system(size: 12))
                    .foregroundStyle(ThemeManager.white)
                }else{
                    TextField(text: $userInput) {
                        Text(placeHolder)
                            .foregroundStyle(ThemeManager.white)
                            .font(.system(size: 12))
                    }
                    .frame(height: 35)
                    .font(.system(size: 12))
                    .foregroundStyle(ThemeManager.white)
                }
            }
            .background(
                errorMessage != nil ? Color.red.opacity(0.45) : Color.gray
            )
            .cornerRadius(8)
            
            // Error text
            if let error = errorMessage {
                Text(error)
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
    }
}

#Preview {
    CustomTextView(isSecure: false, placeHolder: "Enter your email", imageName: "envelope", title: "Email",userInput: .constant(""))
}
