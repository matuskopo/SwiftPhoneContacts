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
//            if let contacts = loadFirebase() {
//                self.contacts = contacts
//            } else {
//                saveToFirebase([ContactModel(name: "CoreData", surname: "Test", phone: "Phone")])
//            }
            
//            database.child("Contact").getData(completion: { error, snapshot in
//                guard error == nil else {
//                    print(error!.localizedDescription)
//                    return
//                }
//                
//                self.contacts.removeAll()
//                
//                if ((snapshot?.exists()) != nil) {
//                    for child in snapshot!.children {
//                        let childSnap = child as? DataSnapshot
//                        let dict = childSnap?.value as? [String: String]
//                        let id = String((child as AnyObject).key)
//                        
//                        var contact = ContactModel(name: "", surname: "", phone: "", id: UUID(uuidString: id) ?? UUID())
//                        contact.name = dict?["name"] ?? ""
//                        contact.surname = dict?["surname"] ?? ""
//                        contact.phone = dict?["phoneNumber"] ?? ""
//                        
//                        self.contacts.append(contact)
//                    }
//                }
//                
//            })
            
            let semaphore = DispatchSemaphore(value: 1)
            
            loadFirebase(completion: { array in
                self.contacts = array
                semaphore.signal()
            })
            
//            if self.contacts.isEmpty {
//                saveToFirebase([ContactModel(name: "CoreData", surname: "Test", phone: "Phone")])
//            }
            
            semaphore.wait()
            loaded = true
        }
        
        return contacts
    }
    
    func add(_ contact: ContactModel) {
        contacts.append(contact)
        saveToFirebase(contacts)
        
        loaded = false
    }
    
    func edit(_ contact: ContactModel) {
        if let index = contacts.firstIndex(where: { $0.id == contact.id }) {
            contacts[index] = contact
        }
        saveToFirebase(contacts)
        
        loaded = false
    }
    
    func delete(_ contact: ContactModel) {
        if let index = contacts.firstIndex(where: { $0.id == contact.id }) {
            contacts.remove(at: index)
        }
        saveToFirebase(contacts)
        
        loaded = false
    }
    
    // MARK: - private methods
    
    private func loadFirebase(completion: @escaping (_ returnedArray: [ContactModel]) -> Void) {
        
        var returnedArray: [ContactModel] = []
        
        database.child("Contact").observeSingleEvent(of: .value, with: { snapshot in
            for child in snapshot.children {
                let childSnap = child as? DataSnapshot
                let dict = childSnap?.value as? [String: String]
                let id = String((child as AnyObject).key)
                
                var contact = ContactModel(name: "", surname: "", phone: "", id: UUID(uuidString: id) ?? UUID())
                contact.name = dict?["name"] ?? ""
                contact.surname = dict?["surname"] ?? ""
                contact.phone = dict?["phoneNumber"] ?? ""
                
                returnedArray.append(contact)
            }
            
            completion(returnedArray)
        })
        
//        database.child("Contact").getData(completion: { error, snapshot in
//            guard error == nil else {
//                print(error!.localizedDescription)
//                return
//            }
//            
//            self.contacts.removeAll()
//            
//            if ((snapshot?.exists()) != nil) {
//                for child in snapshot!.children {
//                    let childSnap = child as? DataSnapshot
//                    let dict = childSnap?.value as? [String: String]
//                    let id = String((child as AnyObject).key)
//                    
//                    var contact = ContactModel(name: "", surname: "", phone: "", id: UUID(uuidString: id) ?? UUID())
//                    contact.name = dict?["name"] ?? ""
//                    contact.surname = dict?["surname"] ?? ""
//                    contact.phone = dict?["phoneNumber"] ?? ""
//                    
//                    self.contacts.append(contact)
//                }
//            }
//            
//            completion(self.contacts)
//        })
    }
    
    private func saveToFirebase(_ data: [ContactModel]) {
        database.child("Contact").removeValue()
        
        for contact in data {
            let object: [String: String] = [
                "name": contact.name,
                "surname": contact.surname,
                "phoneNumber": contact.phone
            ]
            
            database.child("Contact").child(contact.id.description).setValue(object)
        }
    }
}
