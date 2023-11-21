//
//  ContactListM2View.swift
//  PhoneContacts
//
//  Created by Matus Kivader on 16/11/2023.
//

import SwiftUI
import M2UILibrary

struct ContactListM2View: View {
    
    @State private var contacts: [ContactModel] = []
    
    let cardModel = M2UIScreenCardsModel()
    
    var body: some View {
        cardModel
            .build()
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    AddContactM2View()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .onAppear {
            Resources.sharedInstance.dataManager.load { returnedArray in
                self.contacts = returnedArray
                
                self.contacts.sort{$0.name.lowercased() < $1.name.lowercased()}
                
                cardModel.removeAllCards()
                contacts.forEach({ contact in
                    let card = M2UICardModel()
                                .header(M2UICardModel.HeaderModel()
                                    .headline("\(contact.name) \(contact.surname)")
                                    .subHeadline(contact.phone)
                                    .trailingIcon(Image("trailingIcon")))
                    
                    _ = cardModel.addCard(card)
                })
            }
        }
    }
    
    
}

#Preview {
    ContactListM2View()
}
