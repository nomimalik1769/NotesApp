//
//  DashboardView.swift
//  NotesApp
//
//  Created by MNouman on 06/09/2025.
//

import SwiftUI
import SwiftData

struct DashboardView: View {
    @StateObject private var defaults = DefaultsManager.shared
    @Query var allNotes : [Note] = []
    
    var body: some View {
        VStack(alignment: .leading,spacing: 10){
            HStack(alignment:.center){
                Image("userplaceholder")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .overlay(
                        Circle()
                            .stroke(lineWidth: 1)
                            .fill(
                                LinearGradient(colors: [.orange,.pink], startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                    )
                
                VStack(alignment:.leading){
                    Text("Welcome back, \(defaults.profile?.name ?? "")!")
                        .font(.headline)
                    Text("Here's an overview of your notes activity")
                        .font(.caption)
                        .foregroundStyle(Color.secondary)
                }
                Spacer()
                
            }
            .padding(.horizontal,15)
            
            List{
                ForEach(0..<1){_ in
                    DashboardCardView(allNotes: allNotes)
                }
                .listRowSeparator(.hidden, edges: .all)
                .listRowBackground(Color(.systemGray6))
                .listRowInsets(EdgeInsets.init(top: 0, leading: 12, bottom: 10, trailing: 12))
                .listSectionSpacing(.zero)
                
            }
            .listStyle(.plain)
            
        }
        .frame(maxWidth:.infinity)
        .background(Color(.systemGray6))
    }
}

#Preview {
    DashboardView()
}


struct DashboardCardView:View {
    @State var allNotes : [Note]
    var body: some View {
        VStack(spacing: 100){
            HStack{
                Text("Total Notes")
                    .font(.subheadline)
                    .bold()
                Spacer()
                Image(systemName: "folder")
                    .foregroundStyle(Color.secondary)
            }
            
            VStack(alignment: .leading){
                Text("\(allNotes.count)")
                    .font(.headline)
                    .bold()
                Text("All time")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth:.infinity,alignment: .leading)
            
            
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
        )
        
    }
}

#Preview {
    DashboardCardView(allNotes: [])
}
