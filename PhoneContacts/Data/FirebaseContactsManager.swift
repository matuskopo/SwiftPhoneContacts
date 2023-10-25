//
//  FirebaseContactsManager.swift
//  PhoneContacts
//
//  Created by Matus Kivader on 25/10/2023.
//

import Foundation

class FirebaseContactsManager: ContactsManager {
    
    func load() -> [ContactModel] {
        return [ContactModel(name: "Firebase", surname: "Test", phone: "Phone")]
    }
    
    func add(_ contact: ContactModel) {
        
    }
    
    func edit(_ contact: ContactModel) {
        
    }
    
    func delete(_ contact: ContactModel) {
        
    }
    
    
}
