//
//  NewNoteView.swift
//  NotesApp
//
//  Created by MNouman on 06/09/2025.
//

import SwiftUI
import SwiftData

struct NewNoteView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State var titleName: String = ""
    @State var content: String = ""
    
    @Binding var selectedNote :Note?
    
    
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
                    
                    Button(action:{saveNewNote()},label:{
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
        .onAppear {
            if let selectedNote{
                titleName = selectedNote.title
                content = selectedNote.body
            }
        }
        
    }
    private func saveNewNote(){
        if selectedNote != nil{
            updateNote()
            
        }else{
            if !titleName.isEmpty && !content.isEmpty{
                let newNote = Note(title: titleName, body: content, date: Date())
                modelContext.insert(newNote)
                dismiss()
            }
        }
    }
    private func updateNote(){
        if !titleName.isEmpty && !content.isEmpty{
            guard let selectedNote else {return}
            let idOf = selectedNote.id
            let getNote = #Predicate<Note>{$0.id == idOf}
            var descriptor = FetchDescriptor(predicate: getNote)
            descriptor.fetchLimit = 1
            if let fetchedFirstNote = try? modelContext.fetch(descriptor).first{
                fetchedFirstNote.title = titleName
                fetchedFirstNote.body = content
                try? modelContext.save()
                dismiss()
            }
            
            
        }
    }
}

#Preview {
    NewNoteView(selectedNote: .constant(nil))
}
