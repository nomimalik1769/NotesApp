//
//  DefaultsManager.swift
//  NotesApp
//
//  Created by MNouman on 11/09/2025.
//


import SwiftUI

enum DefaultsKey {
    static let username   = "username"
    static let isLoggedIn = "isLoggedIn"
    static let profile    = "profile"     // Codable model
}
final class DefaultsManager: ObservableObject {
    static let shared = DefaultsManager()
    private let store: UserDefaults
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    
    @Published var isLoggedIn: Bool {
        didSet { store.set(isLoggedIn, forKey: DefaultsKey.isLoggedIn) }
    }

    // MARK: - Published Codable model
    @Published var profile: UserDTO? {
        didSet { saveCodable(profile, forKey: DefaultsKey.profile) }
    }

    // MARK: - Init
    init(store: UserDefaults = .standard) {
        self.store = store
        self.isLoggedIn = store.object(forKey: DefaultsKey.isLoggedIn) as? Bool ?? false
        self.profile    = loadCodable(UserDTO.self, forKey: DefaultsKey.profile)
    }

    // MARK: - Codable helpers
    private func saveCodable<T: Codable>(_ value: T?, forKey key: String) {
        if let value {
            do {
                let data = try encoder.encode(value)
                store.set(data, forKey: key)
            } catch {
                print("Defaults encode error (\(key)): \(error)")
            }
        } else {
            store.removeObject(forKey: key)
        }
    }

    private func loadCodable<T: Codable>(_ type: T.Type, forKey key: String) -> T? {
        guard let data = store.data(forKey: key) else { return nil }
        do { return try decoder.decode(T.self, from: data) }
        catch {
            print("Defaults decode error (\(key)): \(error)")
            return nil
        }
    }

    // MARK: - Utilities
    func clearAll() {
        store.removeObject(forKey: DefaultsKey.username)
        store.removeObject(forKey: DefaultsKey.isLoggedIn)
        store.removeObject(forKey: DefaultsKey.profile)
        // reflect in memory:
        isLoggedIn = false
        profile = nil
    }
}
