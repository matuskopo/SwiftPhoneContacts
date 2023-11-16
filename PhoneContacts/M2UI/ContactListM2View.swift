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
    
    let table = M2UIScreenTableModel()
    let section = M2UIScreenTableModel.Section()
    
    var body: some View {
        table
            .addSection(section)
            .build()
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
                
                table.removeAllRows()
                contacts.forEach({ contact in
                    _ = section.addRow(
                        M2UIScreenTableModel.Row(text: "\(contact.name) \(contact.surname)")
                            .addDetailItem(M2UITextModel(text: contact.phone).style(.subHeadline))
                    )
                })
            }
        }
    }
    
    
}

#Preview {
    ContactListM2View()
}
