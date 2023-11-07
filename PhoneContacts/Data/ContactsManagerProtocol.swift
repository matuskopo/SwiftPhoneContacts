//
//  ContactsManagerProtocol.swift
//  PhoneContacts
//
//  Created by Matus Kivader on 25/10/2023.
//

import Foundation

protocol ContactsManager {
    
    func load(completion: @escaping (_ returnedArray: [ContactModel]) -> Void)
    func add(_ contact: ContactModel)
    func edit(_ contact: ContactModel)
    func delete(_ contact: ContactModel)
    
}
