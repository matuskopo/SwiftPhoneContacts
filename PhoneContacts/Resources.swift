//
//  Resources.swift
//  PhoneContacts
//
//  Created by Matus Kivader on 25/10/2023.
//

import Foundation

class Resources {
    
    static let sharedInstance = Resources()
    
    var dataManager: ContactsManager = JSONContactsManager()
    
}
