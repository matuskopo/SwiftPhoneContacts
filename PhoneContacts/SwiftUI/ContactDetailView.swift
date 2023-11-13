//
//  ContactDetailView.swift
//  PhoneContacts
//
//  Created by Matus Kivader on 10/11/2023.
//

import SwiftUI

struct ContactDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var contact: ContactModel
    
    var contactManager = Resources.sharedInstance.dataManager
    
    var body: some View {
        VStack {
            VStack(alignment: .center) {
                ZStack {
                    Circle()
                        .fill(CustomColor.shrimp)
                        .frame(width: 100, height: 100)
                    
                    Text("\((contact.name.prefix(1)).uppercased() + (contact.surname.prefix(1)).uppercased())"
                        .trimmingCharacters(in: .whitespacesAndNewlines)
                    )
                    .foregroundStyle(.white)
                    .font(.system(size: 25))
                    .fontWeight(.bold)
                        
                }
                .padding(.bottom, 10)
                
                Text("\(contact.name) \(contact.surname)")
                    .font(.title)
            }
            
            Text(contact.phone)
            
            Spacer()
            
            Button {
                contactManager.delete(contact)
                
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Delejte")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(.red)
            
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    EditContactView(contact: contact)
                } label: {
                    Text("Edit")
                }
            }
        }
        .padding(10)
        .background(CustomColor.bg1)
    }
}

#Preview {
    ContactDetailView(contact: ContactModel(name: "Jozo", surname: "Kubani", phone: "0944918762"))
}
