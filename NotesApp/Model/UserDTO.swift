//
//  UserDTO.swift
//  NotesApp
//
//  Created by MNouman on 11/09/2025.
//


struct UserDTO: Codable {
    let email: String
    let name: String
    let password: String
}
extension UserModel {
    var dto: UserDTO { UserDTO(email: email, name: name, password: password) }
    
    convenience init(from dto: UserDTO) {
        self.init(email: dto.email, name: dto.name, password: dto.password)
    }
}
