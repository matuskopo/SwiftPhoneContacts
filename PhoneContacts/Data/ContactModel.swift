//
//  ContactModel.swift
//  PhoneContacts
//
//  Created by Matus Kivader on 25/10/2023.
//

import Foundation

struct ContactModel: Codable {
    let id: UUID
    var name: String
    var surname: String
    var phone: String
    
    init(name: String, surname: String, phone: String, id: UUID = UUID()) {
        self.name = name
        self.surname = surname
        self.phone = phone
        
        self.id = id
    }
}
