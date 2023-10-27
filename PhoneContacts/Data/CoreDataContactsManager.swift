//
//  CoreDataContactsManager.swift
//  PhoneContacts
//
//  Created by Matus Kivader on 25/10/2023.
//

import Foundation
import UIKit
import CoreData

class CoreDataContactsManager: ContactsManager {
    
    var contacts: [ContactModel] = []
    var loaded = false
    
    func load() -> [ContactModel] {
        if !loaded {
            if let contacts = loadCoreData() {
                self.contacts = contacts
            } else {
                contacts[0] = ContactModel(name: "CoreData", surname: "Test", phone: "Phone")
                //TODO - save to core data
            }
            
            loaded = true
        }
        
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
    
    private func loadCoreData() -> [ContactModel]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return contacts }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Contacts")
        
        var loadedData: [ContactModel] = []
        var index: Int = 0
        do {
            guard let result = try managedContext.fetch(fetchRequest) as? [NSManagedObject] else { return nil }
            for data in result {
                loadedData[index].name = data.value(forKey: "name") as? String ?? ""
                loadedData[index].surname = data.value(forKey: "surname") as? String ?? ""
                loadedData[index].phone = data.value(forKey: "phoneNumber") as? String ?? ""
                index += 1
            }
            
            return loadedData
        } catch let error as NSError {
            print(error)
        }
        
        return nil
    }
    
    private func saveCoreData(_ data: [ContactModel]) {
        
    }
    
}
