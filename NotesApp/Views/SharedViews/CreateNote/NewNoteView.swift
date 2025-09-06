//
//  NewNoteView.swift
//  NotesApp
//
//  Created by MNouman on 06/09/2025.
//

import SwiftUI

struct NewNoteView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State var titleName: String = ""
    @State var content: String = ""
    
    var body: some View {
        ZStack{
            Color(.black.withAlphaComponent(0.45)).ignoresSafeArea()
            VStack{
                HStack{
                    Spacer()
                    Text("Create New Note")
                        .font(.title3)
                        .fontWeight(.semibold)
                    Spacer()
                    Button(action: {
                        dismiss()
                    },label:{
                        Image(systemName: "xmark")
                            .tint(Color.black)
                    })
                        
                }
                .padding(12)
                VStack{
                    CustomTextView(isSecure: false, placeHolder: "Enter note title", imageName: "", title: "Title", userInput: $titleName)
                    CustomTextView(isSecure: false, placeHolder: "Write your content here", imageName: "", title: "Content", userInput: $content,isTextEditor: true)
                }
                .padding(12)
                
                HStack{
                    Spacer()
                    Button(action:{dismiss()},label:{
                        Text("Cancel")
                    })
                    .buttonStyle(BorderedProminentButtonStyle())
                    .tint(Color(.systemGray5))
                    .foregroundStyle(.black)
                    .font(.subheadline)
                    
                    Button(action:{},label:{
                        Text("Create Note")
                    })
                    .buttonStyle(BorderedProminentButtonStyle())
                    .tint(Color.black)
                    .font(.subheadline)
                }
                .padding()
            }
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(.white))
            )
            .frame(maxWidth: .infinity,alignment: .center)
            .padding()
            
        }
        
    }
}

#Preview {
    NewNoteView()
}
