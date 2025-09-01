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
}

// 2) Root container that owns the NavigationStack + path
struct RootNavView: View {
    @State private var path: [Route] = []

    var body: some View {
        NavigationStack(path: $path) {
            LoginView(onSignupTap: {            // push via button
                path.append(.signup)
            })
            .toolbarVisibility(.hidden, for: .navigationBar)
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .signup:
                    SignupView(onSignInTap: {})
                    
                }
            }
        }
        .toolbarVisibility(.hidden, for: .navigationBar)
        
    }
}


#Preview {
    RootNavView()
}
