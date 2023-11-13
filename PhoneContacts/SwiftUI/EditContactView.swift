//
//  EditContactView.swift
//  PhoneContacts
//
//  Created by Matus Kivader on 13/11/2023.
//

import SwiftUI

struct EditContactView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name: String = ""
    @State private var surname: String = ""
    @State private var phone: String = ""
    
    @State private var presentAlert1: Bool = false
    @State private var presentAlert2: Bool = false
    
    var contact: ContactModel
    var contactManager = Resources.sharedInstance.dataManager
    
    var body: some View {
        VStack {
            TextField("Name", text: $name)
                .textFieldStyle(.roundedBorder)
                .padding(.bottom, -8)
                .font(.system(size: 14))
            TextField("Surname", text: $surname)
                .textFieldStyle(.roundedBorder)
                .padding(.bottom, -8)
                .font(.system(size: 14))
            TextField("Phone number", text: $phone)
                .textFieldStyle(.roundedBorder)
                .padding(.bottom, -8)
                .font(.system(size: 14))
            
            Button {
                guard !(name.isEmpty) else {
                    presentAlert1 = true
                    return
                }
                guard !(phone.isEmpty) else {
                    presentAlert2 = true
                    return
                }
                
                contactManager.edit(ContactModel(
                    name: name,
                    surname: surname,
                    phone: phone,
                    id: contact.id
                ))
                
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Edit")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            
            ZStack {}
                .alert(isPresented: $presentAlert1) {
                    Alert(
                        title: Text("No Name?:("),
                        dismissButton: .default(Text("OK")))
                }
            ZStack {}
                .alert(isPresented: $presentAlert2) {
                    Alert(
                        title: Text("No Number?:("),
                        dismissButton: .default(Text("OK")))
                }
        }
        .onAppear {
            name = contact.name
            surname = contact.surname
            phone = contact.phone
        }
    }
}

#Preview {
    EditContactView(contact: ContactModel(name: "Jozo", surname: "Kubani", phone: "0944918762"))
}
