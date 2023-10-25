//
//  ContactListView.swift
//  PhoneContacts
//
//  Created by Matus Kivader on 25/10/2023.
//

import SwiftUI

struct ContactListView: View {
    
    private var contacts: [ContactModel] = []
    
    init(contacts: [ContactModel]) {
        self.contacts = contacts
    }
    
    var body: some View {
        List(contacts) { contact in
            VStack(alignment: .leading) {
                Text("\(contact.name) \(contact.surname)")
                Text(contact.phone)
            }
        }
    }
}

struct ContactListView_Previews: PreviewProvider {
    static var previews: some View {
        ContactListView(contacts: [])
    }
}
