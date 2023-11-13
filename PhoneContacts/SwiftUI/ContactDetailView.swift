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
                
                Text("\(contact.name) \(contact.surname)")
                    .font(.title)
            }
            Text(contact.phone)
            
            Spacer()
            
            Button {
                
            } label: {
                Text("Delejte")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(.red)
            
        }
        .padding(10)
        .background(CustomColor.bg1)
    }
}

#Preview {
    ContactDetailView(contact: ContactModel(name: "Jozo", surname: "Kubani", phone: "0944918762"))
}
