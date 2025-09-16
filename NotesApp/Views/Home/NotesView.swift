//
//  NotesView.swift
//  NotesApp
//
//  Created by MNouman on 03/09/2025.
//

import SwiftUI
import SwiftData

struct NotesView: View {
    var onNewNote: (() -> Void)?
    @State private var searchText = ""
    @State private var selectedNote:Note?
    @State private var presentingAddNote: Bool = false
    @Query private var allNotes: [Note]
    
    @Environment(\.modelContext) private var modelContext
       
    var body: some View {
        List{
            VStack(alignment:.leading,spacing: 20){
                VStack(alignment:.leading){
                    Text("My Notes")
                        .font(.title2)
                        .bold()
                    Text("^[\(filteredNotes.count) Note](inflect:true) total")
                        .font(.caption)
                    
                    HStack(spacing:5){
                        Image(systemName: "plus")
                        Text("New Note").fontWeight(.semibold)
                    }
                    .onTapGesture {
                        selectedNote = nil
                        presentingAddNote = true
                    }
                    .padding(.horizontal,12)
                    .padding(.vertical,8)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.black)
                    )
                    .foregroundStyle(LinearGradient(colors: [Color.blue,Color.white], startPoint: .leading, endPoint: .trailing))
                    .bold()
                 
                }
                
                //Search
                
                HStack(spacing:8){
                    Image(systemName: "magnifyingglass")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                    TextField("Search notes...", text: $searchText)
                        .font(.callout)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(Color.gray.opacity(0.12))
                )
                
                ForEach(filteredNotes){item in
                    NoteCard(title: item.title, bodyPreview: item.body, dateString: item.date.formatted(date: .long, time: .shortened)) {
                        selectedNote = item
                        presentingAddNote = true
                    } onDelete: {
                        deleteNote(item: item)
                    }

                }
                
            }
            .listRowInsets(EdgeInsets(top: 12, leading: 12, bottom: 8, trailing: 12))
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden, edges: .all)
        }
        .listStyle(.plain)
        
        .fullScreenCover(isPresented: $presentingAddNote) {
            NewNoteView(selectedNote: $selectedNote)
                .presentationBackground(.clear)
        }
            
        
    }
    private var filteredNotes: [Note] {
        searchText.isEmpty
        ? allNotes
        : allNotes.filter { $0.title.localizedCaseInsensitiveContains(searchText) ||
                         $0.body.localizedCaseInsensitiveContains(searchText) }
    }
    private func deleteNote(item:Note){
      
        modelContext.delete(item)
        try? modelContext.save()
    }
}

#Preview {
    NotesView()
}
