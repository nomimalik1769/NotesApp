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
    var isTextEditor : Bool = false
    
    var errorMessage: String? = nil

    
    var body: some View {
        VStack(alignment: .leading,spacing: 4){
            Text(title)
                .font(.subheadline)
                .bold()
            HStack{
                if imageName != ""{
                    Image(systemName:imageName).frame(width: 16, height: 16).padding(.leading,8)
                        .foregroundStyle(ThemeManager.black)
                }else{
                    Spacer(minLength: 12)
                }
                if isSecure{
                    SecureField(text: $userInput) {
                        Text(placeHolder)
                            .foregroundStyle(ThemeManager.black)
                            .font(.system(size: 12))
                    }
                    .frame(height: 35)
                    .font(.system(size: 12))
                    .foregroundStyle(ThemeManager.black)
                }else{
                    if isTextEditor{
                        TextEditor(text: $userInput)
                            .font(.system(size: 12))
                            .foregroundColor(.primary)                  // make sure text is visible
                            .padding(4)
                            .frame(minHeight: 50, maxHeight: 120)       // give it a bit of room
                            .scrollContentBackground(.hidden)           // hide default UITextView bg
                            .background(Color(.systemGray6))       // actual visible bg
                            
                        
                    }else{
                        TextField(text: $userInput) {
                            Text(placeHolder)
                                .foregroundStyle(ThemeManager.black)
                                .font(.system(size: 12))
                        }
                        .frame(height: 35)
                        .font(.system(size: 12))
                        .foregroundStyle(ThemeManager.black)
                    }
                    
                }
            }
            .frame(maxWidth: .infinity)
            .background(
                errorMessage != nil ? Color.red.opacity(0.45) : Color(.systemGray6)
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
    CustomTextView(isSecure: false, placeHolder: "Enter your email", imageName: "envelope", title: "Email",userInput: .constant(""),isTextEditor: true)
}
