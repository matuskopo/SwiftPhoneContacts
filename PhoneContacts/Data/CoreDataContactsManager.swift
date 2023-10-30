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
                saveCoreData([ContactModel(name: "CoreData", surname: "Test", phone: "Phone")])
            }
            
            loaded = true
        }
        
        return contacts
    }
    
    func add(_ contact: ContactModel) {
        contacts.append(contact)
        saveCoreData(contacts)
        
        loaded = false
    }
    
    func edit(_ contact: ContactModel) {
        if let index = contacts.firstIndex(where: { $0.id == contact.id }) {
            contacts[index] = contact
        }
        saveCoreData(contacts)
        
        loaded = false
    }
    
    func delete(_ contact: ContactModel) {
        if let index = contacts.firstIndex(where: { $0.id == contact.id }) {
            contacts.remove(at: index)
        }
        saveCoreData(contacts)
        
        loaded = false
    }
    
    // MARK: - private methods
    
    private func loadCoreData() -> [ContactModel]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
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
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let contactsEntity = NSEntityDescription.entity(forEntityName: "Contacts", in: managedContext) else { return }
        
        for contact in data {
            let contacts = NSManagedObject(entity: contactsEntity, insertInto: managedContext)
            
            contacts.setValue(contact.name, forKey: "name")
            contacts.setValue(contact.surname, forKey: "surname")
            contacts.setValue(contact.phone, forKey: "phoneNumber")
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
}
