//
//  ContactDetailView.swift
//  PhoneContacts
//
//  Created by Matus Kivader on 10/11/2023.
//

import SwiftUI

struct ContactDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var selectedContact: ContactModel
    
    var contactManager = Resources.sharedInstance.dataManager
    
    var body: some View {
        VStack {
            VStack(alignment: .center) {
                ZStack {
                    Circle()
                        .fill(CustomColor.shrimp)
                        .frame(width: 100, height: 100)
                    
                    Text("\((selectedContact.name.prefix(1)).uppercased() + (selectedContact.surname.prefix(1)).uppercased())"
                        .trimmingCharacters(in: .whitespacesAndNewlines)
                    )
                    .foregroundStyle(.white)
                    .font(.system(size: 25))
                    .fontWeight(.bold)
                        
                }
                .padding(.bottom, 10)
                
                Text("\(selectedContact.name) \(selectedContact.surname)")
                    .font(.title)
            }
            
            HStack {
                button(action: {}, icon: "message.fill", name: "message")
                button(action: {}, icon: "phone.fill", name: "mobile")
                button(action: {}, icon: "video.fill", name: "video")
                button(action: {}, icon: "envelope.fill", name: "mail")
            }
            .padding(.bottom, 10)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Phone")
                        .font(.system(size: 12))
                        .padding(.bottom, 2)
                    Text(selectedContact.phone)
                        .font(.system(size: 17))
                }
                .padding(.leading)
                .padding([.top, .bottom], 3)
                
                Spacer()
            }
            .background(Color(.white))
            .clipShape(RoundedRectangle(cornerRadius: 5))
            
            Spacer()
            
            Button {
                contactManager.delete(selectedContact)
                
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Delejte")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(.red)
            
        }
        .onAppear {
            contactManager.load { returnedArray in
                self.selectedContact = returnedArray.filter({ $0.id == self.selectedContact.id }).first ?? self.selectedContact
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    EditContactView(contact: selectedContact)
                } label: {
                    Text("Edit")
                }
            }
        }
        .padding(10)
        .background(CustomColor.bg1)
    }
    
    @ViewBuilder
    func button(action: @escaping (() -> ()), icon: String, name: String) -> some View {
        Button {
            action()
        } label: {
            VStack {
                Image(systemName: icon)
                    .padding(.bottom, -2)
                Text(name)
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 12))
            }
        }
        .buttonStyle(.borderedProminent)
        .tint(.white)
        .foregroundColor(Color(uiColor: .systemBlue))
    }
}

#Preview {
    ContactDetailView(selectedContact: ContactModel(name: "Jozo", surname: "Kubani", phone: "0944918762"))
}
