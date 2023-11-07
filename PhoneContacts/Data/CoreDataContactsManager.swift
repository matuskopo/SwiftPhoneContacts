//
//  CoreDataContactsManager.swift
//  PhoneContacts
//
//  Created by Matus Kivader on 25/10/2023.
//

import UIKit
import CoreData

class CoreDataContactsManager: ContactsManager {
    
    var contacts: [ContactModel] = []
    var loaded = false
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    func load(completion: @escaping (_ returnedArray: [ContactModel]) -> Void) {
        if !loaded {
            if let contacts = loadCoreData() {
                self.contacts = contacts
            } else {
                saveCoreData([ContactModel(name: "CoreData", surname: "Test", phone: "Phone")])
            }
            
            loaded = true
        }
        
        completion(contacts)
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
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        guard (appDelegate != nil) else {
            return nil
        }
        let managedContext = appDelegate!.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Contacts")
        
        do {
            guard let result = try managedContext.fetch(fetchRequest) as? [NSManagedObject] else { return nil }
            
            var array: [ContactModel] = []
            for data in result {
                var contact = ContactModel(name: "", surname: "", phone: "", id: data.value(forKey: "id") as! UUID)
                
                contact.name = data.value(forKey: "name") as! String
                contact.surname = data.value(forKey: "surname") as! String
                contact.phone = data.value(forKey: "phoneNumber") as! String
                
                array.append(contact)
            }
            
            if array.isEmpty {
                return nil
            }
            return array
        } catch let error as NSError {
            print(error)
        }
        
        return nil
    }
    
    private func saveCoreData(_ data: [ContactModel]) {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate!.persistentContainer.viewContext
        guard let contactsEntity = NSEntityDescription.entity(forEntityName: "Contacts", in: managedContext) else { return }
        
        deleteAllData()
        
        for contact in data {
            let contacts = NSManagedObject(entity: contactsEntity, insertInto: managedContext)
            
            contacts.setValue(contact.name, forKey: "name")
            contacts.setValue(contact.surname, forKey: "surname")
            contacts.setValue(contact.phone, forKey: "phoneNumber")
            contacts.setValue(contact.id, forKey: "id")
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    private func deleteAllData() {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        guard (appDelegate != nil) else {
            return
        }
        let managedContext = appDelegate!.persistentContainer.viewContext
        let entityNames = appDelegate!.persistentContainer.managedObjectModel.entities.map({ $0.name! })
        entityNames.forEach { [weak managedContext] entityName in
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)

            do {
                try managedContext?.execute(deleteRequest)
                try managedContext?.save()
            } catch let error as NSError {
                debugPrint(error)
            }
        }
    }
    
}
