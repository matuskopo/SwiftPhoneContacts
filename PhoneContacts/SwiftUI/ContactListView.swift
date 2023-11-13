//
//  ContactListView.swift
//  PhoneContacts
//
//  Created by Matus Kivader on 25/10/2023.
//

import SwiftUI

struct ContactListView: View {
    
    @State private var contacts: [ContactModel] = []
    
    var body: some View {
        List(contacts) { contact in
            NavigationLink {
                ContactDetailView(contact: contact)
            } label: {
                VStack(alignment: .leading) {
                    Text("\(contact.name) \(contact.surname)")
                    Text(contact.phone)
                        .font(.system(size: 12))
                }
            }
            .padding([.top, .bottom], -3)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    AddContactView()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .onAppear {
            Resources.sharedInstance.dataManager.load { returnedArray in
                self.contacts = returnedArray
                
                self.contacts.sort{$0.name.lowercased() < $1.name.lowercased()}
            }
        }
    }
    
}

struct ContactListView_Previews: PreviewProvider {
    static var previews: some View {
        ContactListView()
    }
}
