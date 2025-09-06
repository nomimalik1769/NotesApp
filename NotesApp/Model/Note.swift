//
//  Note.swift
//  NotesApp
//
//  Created by MNouman on 03/09/2025.
//

import SwiftUI

struct Note: Identifiable {
    let id = UUID()
    var title: String
    var body: String
    var date: Date
}
