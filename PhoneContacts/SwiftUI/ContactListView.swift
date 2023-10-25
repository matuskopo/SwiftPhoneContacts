//
//  ContactListView.swift
//  PhoneContacts
//
//  Created by Matus Kivader on 25/10/2023.
//

import SwiftUI

struct ContactListView: View {
    
    struct Contact: Identifiable, Hashable {
        let name: String
        let phone: String
        
        let id = UUID()
    }

    private var contacts = [
        Contact(name: "Test", phone: "Phone"),
        Contact(name: "Test", phone: "Phone"),
        Contact(name: "Test", phone: "Phone"),
        Contact(name: "Test", phone: "Phone"),
        Contact(name: "Test", phone: "Phone"),
        Contact(name: "Test", phone: "Phone"),
        Contact(name: "Test", phone: "Phone"),
        Contact(name: "Test", phone: "Phone")
    ]
    
    var body: some View {
        List(contacts) { contact in
            VStack(alignment: .leading) {
                Text(contact.name)
                Text(contact.phone)
            }
        }
    }
}

struct ContactListView_Previews: PreviewProvider {
    static var previews: some View {
        ContactListView()
    }
}
