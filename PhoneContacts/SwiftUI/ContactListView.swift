//
//  ContactListView.swift
//  PhoneContacts
//
//  Created by Matus Kivader on 25/10/2023.
//

import SwiftUI

struct ContactDetailView: View {
    let contact: ContactModel
    @Binding var contacts: [ContactModel]
    @State private var isShowingAlert = false
    @State private var isEditingContact = false
    @State private var editedName: String = ""
    @State private var editedSurname: String = ""
    @State private var editedPhone: String = ""

    var body: some View {
        VStack {
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundColor(.blue)
                .background(Circle().foregroundColor(Color(red: 0.9, green: 0.9, blue: 0.9)))

            Text("\(contact.name) \(contact.surname)")
                .font(.title)
                .foregroundColor(.primary)
            
            Text(contact.phone)
                .foregroundColor(.secondary)

            Button(action: {
                isShowingAlert = true
            }) {
                HStack {
                    Image(systemName: "trash.fill")
                    Text("Vymazat kontakt")
                }
                .foregroundColor(.white)
                .padding()
                .background(Color.red)
                .cornerRadius(10)
            }
            .alert(isPresented: $isShowingAlert) {
                Alert(
                    title: Text("Potvrdit"),
                    message: Text("Naozaj chces odstraniť kontakt?"),
                    primaryButton: .default(Text("Ano")) {
                        if let index = contacts.firstIndex(where: { $0.id == contact.id }) {
                            contacts.remove(at: index)
                        }
                    },
                    secondaryButton: .cancel()
                )
            }

            Button(action: {
                isEditingContact = true
                editedName = contact.name
                editedSurname = contact.surname
                editedPhone = contact.phone
            }) {
                HStack {
                    Image(systemName: "pencil")
                    Text("Upravit kontakt")
                }
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
            }
            .fullScreenCover(isPresented: $isEditingContact) {
                VStack {
                    Spacer()
                    VStack(alignment: .center, spacing: 20) {
                        TextField("Meno", text: $editedName)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color(red: 0.9, green: 0.9, blue: 0.9)))
                        TextField("Priezvisko", text: $editedSurname)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color(red: 0.9, green: 0.9, blue: 0.9)))
                        TextField("Telefónne číslo", text: $editedPhone)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color(red: 0.9, green: 0.9, blue: 0.9)))

                        Button(action: {
                            if let index = contacts.firstIndex(where: { $0.id == contact.id }) {
                                contacts[index].name = editedName
                                contacts[index].surname = editedSurname
                                contacts[index].phone = editedPhone
                            }
                            isEditingContact = false
                        }) {
                            HStack {
                                Image(systemName: "square.and.arrow.down")
                                Text("Uložit kontakt")
                            }
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                    }
                    Spacer()
                }
            }
        }
    }
}

struct ContactListView: View {
    @State private var contacts: [ContactModel]

    init(contacts: [ContactModel]) {
        _contacts = State(initialValue: contacts)
    }

    @State private var newContactName: String = ""
    @State private var newContactSurname: String = ""
    @State private var newContactPhone: String = ""
    @State private var isAddingContact = false

    var body: some View {
        NavigationView {
            List {
                ForEach(contacts.indices, id: \.self) { index in
                    NavigationLink(destination: ContactDetailView(contact: contacts[index], contacts: $contacts)) {
                        VStack(alignment: .leading) {
                            Text("\(contacts[index].name) \(contacts[index].surname)")
                                .font(.headline)
                            Text(contacts[index].phone)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationBarTitle("Contacts")
            .navigationBarItems(trailing:
                Button(action: {
                    isAddingContact = true
                }) {
                    HStack {
                        Image(systemName: "person.crop.circle.badge.plus")
                        Text("Pridať kontakt")
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            )
        }
        .fullScreenCover(isPresented: $isAddingContact) {
            VStack {
                Spacer()
                VStack(alignment: .center, spacing: 20) {
                    TextField("Meno", text: $newContactName)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color(red: 0.9, green: 0.9, blue: 0.9)))
                    TextField("Priezvisko", text: $newContactSurname)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color(red: 0.9, green: 0.9, blue: 0.9)))
                    TextField("Telefónne číslo", text: $newContactPhone)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color(red: 0.9, green: 0.9, blue: 0.9)))

                    Button(action: {
                        let newContact = ContactModel(name: newContactName, surname: newContactSurname, phone: newContactPhone)
                        contacts.append(newContact)
                        newContactName = ""
                        newContactSurname = ""
                        newContactPhone = ""
                        isAddingContact = false
                    }) {
                        HStack {
                            Image(systemName: "person.crop.circle.badge.checkmark")
                            Text("Uložit kontakt")
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                }
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContactListView(contacts: [])
    }
}
