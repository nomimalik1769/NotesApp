//
//  ProfileView.swift
//  NotesApp
//
//  Created by MNouman on 04/09/2025.
//

import SwiftUI

struct ProfileView: View {
    
    @State var fullName: String = ""
    @State var emailAddress: String = ""
    
    @State var isEditingEnable : Bool = false
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                Text("Profile Settings")
                    .font(.title2)
                    .fontWeight(.semibold)
                Text("Manage your account information and preferences")
                    .font(.subheadline)
                    .foregroundStyle(Color(.black).opacity(0.75))
            }
            .padding(.horizontal,12)
            .frame(maxWidth: .infinity,alignment: .leading)
            Spacer(minLength: 24)
            Group{
                VStack(alignment: .leading){
                    Text("Personal Information")
                        .font(Font.system(size: 14,weight: .medium))
                    
                    VStack(alignment:.center){
                        
                        Image("userplaceholder")
                            .resizable()
                            .frame(width: 80, height: 80, alignment: .center)
                        Spacer(minLength: 12)
                        Text("Click the camera icon to update your profile picture")
                            .font(.caption)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(Color(.black).opacity(0.75))
                        Spacer(minLength: 20)
                        
                        CustomTextView(isSecure: false, placeHolder: "Enter Full Name", imageName: "person", title: "Full Name", userInput: $fullName)
                        Spacer(minLength: 12)
                        CustomTextView(isSecure: false, placeHolder: "Enter Email Address", imageName: "envelope", title: "Email Address", userInput: $emailAddress)
                        Spacer(minLength: 20)
                        HStack(alignment: .center, spacing: 10){
                           Spacer()
                            
                            if isEditingEnable{
                                Button(action: {
                                    withAnimation {
                                        isEditingEnable = false
                                    }
                                }) {
                                    HStack(spacing: 6) {
                                        Image(systemName: "xmark")
                                        Text("Cancel")
                                            .font(.subheadline)
                                            .bold()
                                    }
                                    .frame(height:30)
                                    .foregroundColor(.black)
                                    .padding(.vertical, 4)
                                    .padding(.horizontal, 14)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.black, lineWidth: 1)
                                    )
                                }
                                .buttonStyle(.plain)
                                .padding(.bottom,10)
                                .frame(height:30)
                            }
                            
                            Button(action:{
                                withAnimation {
                                    isEditingEnable.toggle()
                                }
                            },label:{
                                Image(systemName: isEditingEnable ? "sdcard" : "square.and.pencil")
                                Text(isEditingEnable ? "Save Changes" : "Edit Profile")
                                    .font(.subheadline)
                                    .bold()
                                    .padding(.vertical,4)

                            })
                            .frame(height:30)
                            .buttonStyle(BorderedProminentButtonStyle())
                            .foregroundStyle(Color.white)
                            .tint(Color.black)
                            .padding(.bottom,10)
                            
                            
                            
                            
                        }
                    }
                    .frame(maxWidth: .infinity,alignment: .center)
                    
                    
                }
                .padding(.horizontal,16)
                .padding(.vertical,16)
                .frame(maxWidth: .infinity,alignment: .leading)
            }
            
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white)
            )
            .padding(.horizontal,12)
            .padding(.bottom,20)
            
            
            Group{
                VStack(alignment: .leading){
                    Text("Account Information")
                        .font(Font.system(size: 14,weight: .medium))
                    Spacer(minLength: 20)
                    
                    VStack(alignment:.center,spacing:12){
                        CustomTextView(isSecure: false, placeHolder: "User-ID", imageName: "", title: "User-ID", userInput: .constant(""))
                            .allowsHitTesting(false)
                        
                        CustomTextView(isSecure: false, placeHolder: "Account Type", imageName: "", title: "Account Type", userInput: .constant("Standard Type"))
                            .allowsHitTesting(false)
                    }
                }
                .padding(.horizontal,16)
                .padding(.vertical,16)
                .frame(maxWidth: .infinity,alignment: .leading)
            }
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white)
            )
            .padding(.horizontal,12)
            .padding(.bottom,20)
        }
        .background(Color(.systemGray6))
        
    }
}

#Preview {
    ProfileView()
}
