//
//  Note.swift
//  NotesApp
//
//  Created by MNouman on 03/09/2025.
//

import SwiftUI
import SwiftData

@Model
class Note: Identifiable {
    @Attribute(.unique) var id : UUID
    var title: String
    var body: String
    var date: Date
    init(title: String, body: String, date: Date) {
        self.title = title
        self.body = body
        self.date = date
        id = UUID()
    }
}

@Model
class UserModel:Identifiable{
    @Attribute(.unique) var email :String
    var name:String
    var password:String
    init(email: String, name: String, password: String) {
        self.email = email
        self.name = name
        self.password = password
    }
}
