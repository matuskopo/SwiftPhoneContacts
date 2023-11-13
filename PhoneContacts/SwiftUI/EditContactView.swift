//
//  EditContactView.swift
//  PhoneContacts
//
//  Created by Matus Kivader on 13/11/2023.
//

import SwiftUI

struct EditContactView: View {
    var contact: ContactModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    EditContactView(contact: ContactModel(name: "Jozo", surname: "Kubani", phone: "0944918762"))
}
