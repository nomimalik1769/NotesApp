//
//  ContentView.swift
//  NotesApp
//
//  Created by MNouman on 30/08/2025.
//

import SwiftUI
import SwiftData
// 1) Define your routes
enum Route: Hashable {
    case signup
    case none
    case home
}

// 2) Root container that owns the NavigationStack + path
struct RootNavView: View {
    @State private var path: [Route] = []
    @StateObject var defaults = DefaultsManager.shared
    
    let container : ModelContainer = {
        let schema = Schema([Note.self,UserModel.self])
        let innerContainer = try! ModelContainer(for: schema,configurations: [])
        return innerContainer
    }()
    
    var body: some View {
        Group{
            if defaults.isLoggedIn{
                HomeView(onLogout: {
                    defaults.isLoggedIn = false
                })
            }else{
                NavigationStack(path: $path) {
                    LoginView(onSignupTap: {            // push via button
                        path.append(.signup)
                    },onHomeTap: {})
                    .toolbarVisibility(.hidden, for: .navigationBar)
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .signup,.none:
                            SignupView(onSignInTap: {})
                        case .home:
                            HomeView(onLogout: {})
                        }
                    }
                }
                .toolbarVisibility(.hidden, for: .navigationBar)
            }
        }
        .modelContainer(container)
        
    }
    
}


#Preview {
    RootNavView()
}
