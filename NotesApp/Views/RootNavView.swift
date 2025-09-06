//
//  ContentView.swift
//  NotesApp
//
//  Created by MNouman on 30/08/2025.
//

import SwiftUI
// 1) Define your routes
enum Route: Hashable {
    case signup
    case none
    case home
}

// 2) Root container that owns the NavigationStack + path
struct RootNavView: View {
    @State private var path: [Route] = []
    @State var isLoggedIn = false
    
    var body: some View {
        Group{
            if isLoggedIn{
                HomeView(onLogout: {
                    isLoggedIn = false
                })
            }else{
                NavigationStack(path: $path) {
                    LoginView(onSignupTap: {            // push via button
                        path.append(.signup)
                    },onHomeTap: {
                        isLoggedIn = true
                    })
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
        
    }
}


#Preview {
    RootNavView(isLoggedIn: false)
}
