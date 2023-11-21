//
//  AddContactM2View.swift
//  PhoneContacts
//
//  Created by Matus Kivader on 21/11/2023.
//

import SwiftUI

struct AddContactM2View: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name: String = ""
    @State private var surname: String = ""
    @State private var phone: String = ""
    
    @State private var presentAlert1: Bool = false
    @State private var presentAlert2: Bool = false
    
    var contactManager = Resources.sharedInstance.dataManager
    
    var body: some View {
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
            
            contactManager.add(ContactModel(
                name: name,
                surname: surname,
                phone: phone
            ))
            
            presentationMode.wrappedValue.dismiss()
        } label: {
            Text("Add")
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
}

#Preview {
    AddContactM2View()
}
