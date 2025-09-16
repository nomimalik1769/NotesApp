//
//  HomeView.swift
//  NotesApp
//
//  Created by MNouman on 01/09/2025.
//

import SwiftUI

struct HomeView: View {
    let onLogout: () -> Void
    @State private var path: [String] = []  // you can make this an enum like we did for Auth
    @State private var selectedTab: TopTab = .notes
    @StateObject private var defaults = DefaultsManager.shared

    var body: some View {
        NavigationStack(path: $path) {
            ZStack{
                Color(.systemGray6)
                VStack(alignment:.leading) {
                    AppHeaderView(onLogout: onLogout,userName: defaults.profile?.name ?? "")
                    SegmentedTabs(selected: $selectedTab)
                        .padding(.horizontal,12)
                    
                    switch selectedTab {
                    case .notes:
                        NotesView {}
                    case .profile:
                        ProfileView()
                            .padding(.vertical,20)
                    case .dashboard:
                        DashboardView()
                        
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
//                .ignoresSafeArea()
                .navigationDestination(for: String.self) { route in
//                    switch route {
//                    case "newNote":
//                        NewNoteView()
//                    default:
//                        EmptyView()
//                    }
                }
                .navigationBarHidden(true)
            }
        }
    }
    
   
}

#Preview {
    HomeView(onLogout: {})
}
struct AppHeaderView:View{
    
    let onLogout: () -> Void
    let userName: String
    
    var body: some View{
        header:do {
            ZStack{
                
                RoundedRectangle(cornerRadius: 0,style: .continuous)
                    .fill(Color.white)
                    .frame(height: 60)
                
                HStack {
                    
                    // LEFT
                    HStack(spacing: 4) {
                        Image(systemName: "folder")
                            .font(.title2)
                            .foregroundStyle(LinearGradient(colors: [Color.yellow,Color.orange], startPoint: .leading, endPoint: .trailing))
                            .bold()
                        Text("NotesApp")
                            .bold()
                    }
                    
                    Spacer() // push center content
                    
                    // CENTER
                    Text("Welcome, \(userName) user")
                        .font(.system(size: 12))
                    
                    Spacer() // push right content
                    
                    // RIGHT
                    Button(action: {onLogout()}) {
                        HStack(spacing:2){
                            Image(systemName: "rectangle.portrait.and.arrow.forward")
                                .foregroundStyle(.black)
                                .font(Font.system(size: 14))
                            Text("Logout")
                                .font(.system(size: 12,weight: .medium))
                                .foregroundStyle(.black)
                        }
                        .frame(height:30)
                        .padding(.horizontal,6)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .strokeBorder(LinearGradient(colors: [Color.yellow,Color.orange], startPoint: .leading, endPoint: .trailing),lineWidth:1)
                        )
                    }
                }
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
}

// MARK: - Tabs

enum TopTab: String, CaseIterable, Identifiable {
    case notes = "Notes"
    case dashboard = "Dashboard"
    case profile = "Profile"
    var id: String { rawValue }
    var icon: String {
        switch self {
        case .notes: return "folder"
        case .dashboard: return "person.crop.circle"
        case .profile: return "gearshape"
        }
    }
}

struct SegmentedTabs: View {
    @Binding var selected: TopTab
    var body: some View {
        HStack(spacing: 10) {
            ForEach(TopTab.allCases) { tab in
                Button {
                    withAnimation {
                        selected = tab
                    }
                    
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: tab.icon)
                        Text(tab.rawValue)
                    }
                    .font(.system(size: 12, weight: selected == tab ? .semibold : .regular))
                    .padding(.horizontal, 5)
                    .padding(.vertical, 5)
                    .frame(maxWidth: .infinity)
                    .background(
                        Capsule(style: .continuous)
                            .fill(selected == tab
                                  ? Color.white
                                  : Color.clear)
                    )
                    .overlay(
                        Capsule().stroke(Color.gray.opacity(0.25), lineWidth:selected == tab ? 1 : 0)
                    )
                    .foregroundStyle(.primary)
                }
                .buttonStyle(.plain)
                
            }
        }
        .padding(8)
        .background(
            Capsule(style: .continuous)
                .fill(Color.gray.opacity(0.18))
        )
    }
}


struct NoteCard: View {
    var title: String
    var bodyPreview: String
    var dateString: String
    var onEdit: () -> Void
    var onDelete: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top) {
                Text(title)
                    .font(.title3.weight(.semibold))
                Spacer()
                HStack(spacing: 14) {
                    Button(action: onEdit) {
                        Image(systemName: "square.and.pencil")
                    }
                    Button(role: .destructive, action: onDelete) {
                        Image(systemName: "trash")
                    }
                }
                .font(.body)
                .foregroundStyle(.primary)
                .buttonStyle(.plain)
            }
            
            Text(bodyPreview)
                .foregroundStyle(.secondary)
            
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "calendar")
                    Text(dateString)
                }
                .font(.footnote)
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(
                    Capsule(style: .continuous)
                        .fill(Color.gray.opacity(0.15))
                )
                Spacer()
            }
        }
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.06), radius: 8, y: 3)
        )
    }
}
