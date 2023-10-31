//
//  FirebaseContactsManager.swift
//  PhoneContacts
//
//  Created by Matus Kivader on 25/10/2023.
//

import FirebaseDatabase
import UIKit

class FirebaseContactsManager: ContactsManager {
    
    let database = Database.database().reference()
    
    var contacts: [ContactModel] = []
    var loaded = false
    
    func load() -> [ContactModel] {
        if !loaded {
            if let contacts = loadFirebase() {
                self.contacts = contacts
            } else {
                var testContact = ContactModel(name: "Firebase", surname: "Test", phone: "Phone")
                contacts.append(testContact)
                
                for contact in contacts {
                    let object: [String: String] = [
                        "name": contact.name,
                        "surname": contact.surname,
                        "phoneNumber": contact.phone
                    ]
                    
                    database.child(contact.id.description).setValue(object)
                }
            }
            
            loaded = true
        }
//        [ContactModel(name: "Firebase", surname: "Test", phone: "Phone")]
        return contacts
    }
    
    func add(_ contact: ContactModel) {
        contacts.append(contact)
        
        loaded = false
    }
    
    func edit(_ contact: ContactModel) {
        if let index = contacts.firstIndex(where: { $0.id == contact.id }) {
            contacts[index] = contact
        }
        
        loaded = false
    }
    
    func delete(_ contact: ContactModel) {
        if let index = contacts.firstIndex(where: { $0.id == contact.id }) {
            contacts.remove(at: index)
        }
        
        loaded = false
    }
    
    // MARK: - private methods
    
    private func loadFirebase() -> [ContactModel]? {
        return nil
    }
    
    private func saveToFirebase(_ data: [ContactModel]) {
        
    }
}
