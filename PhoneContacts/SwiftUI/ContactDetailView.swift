//
//  ContactDetailView.swift
//  PhoneContacts
//
//  Created by Matus Kivader on 10/11/2023.
//

import SwiftUI

struct ContactDetailView: View {
    var contact: ContactModel
    
    var body: some View {
        VStack(alignment: .center) {
            Text(contact.name)
                .font(.title)
            Text(contact.surname)
            Text(contact.phone)
        }
    }
}

#Preview {
    ContactDetailView(contact: ContactModel(name: "Jozo", surname: "Kubani", phone: "0944918762"))
}
