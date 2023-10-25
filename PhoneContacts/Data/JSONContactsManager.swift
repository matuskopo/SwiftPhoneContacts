//
//  JSONContactsManager.swift
//  PhoneContacts
//
//  Created by Matus Kivader on 25/10/2023.
//

import Foundation

class JSONContactsManager: ContactsManager {
    
    var contacts: [ContactModel] = []
    
    func load() -> [ContactModel] {
        if let contacts = loadJson() {
            self.contacts = contacts
        } else {
            saveToJson([ContactModel(name: "JSON", surname: "Test", phone: "Phone")])
        }
        
        return contacts
    }
    
    func add(_ contact: ContactModel) {
        contacts.append(contact)
        saveToJson(contacts)
    }
    
    func edit(_ contact: ContactModel) {
        if let index = contacts.firstIndex(where: { $0.id == contact.id }) {
            contacts[index] = contact
        }
        saveToJson(contacts)
    }
    
    func delete(_ contact: ContactModel) {
        if let index = contacts.firstIndex(where: { $0.id == contact.id }) {
            contacts.remove(at: index)
        }
        saveToJson(contacts)
    }
    
    // MARK: - private methods
    
    private func loadJson() -> [ContactModel]? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        do {
            let pathWithFileName = documentDirectory.appendingPathComponent("contacts.json")
            let data = try Data(contentsOf: pathWithFileName)
            let result = try JSONDecoder().decode([ContactModel].self, from: data)
            return result
        } catch {
            print(error)
        }
        
        return nil
    }
    
    private func saveToJson(_ data: [ContactModel]) {
        if let jsonData = try? JSONEncoder().encode(data),
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let pathWithFileName = documentDirectory.appendingPathComponent("contacts.json")
            do {
                try jsonData.write(to: pathWithFileName)
            } catch {
                print(error)
            }
        }
    }
}
