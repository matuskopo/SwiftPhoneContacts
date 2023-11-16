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
    
    var body: some View {
        M2UIScreenTableModel()
            .addSection(
                M2UIScreenTableModel.Section()
                    .addRow(M2UIScreenTableModel.Row(text: "Row 1")
                        .addDetailItem(M2UITextModel(text: "detail").style(.subHeadline))
                    )
            ).build()
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

#Preview {
    ContactListM2View()
}
