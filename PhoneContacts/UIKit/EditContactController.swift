//
//  EditContactController.swift
//  PhoneContacts
//
//  Created by Matus Kivader on 27/10/2023.
//

import UIKit

class EditContactController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var surnameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    
    var name: String?
    var surname: String?
    var phone: String?
    var id: UUID?
    
    var contactManager = Resources.sharedInstance.dataManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameField.text = name
        surnameField.text = surname
        phoneField.text = phone
    }
    
    @IBAction func editContact(_ sender: Any) {
        guard !(nameField.text?.isEmpty ?? true) else {
            let alert = UIAlertController(
                title: "No Name?:(",
                message: "",
                preferredStyle: .alert)
            present(alert, animated: true)
            
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            
            return
        }
        
        guard !(phoneField.text?.isEmpty ?? true) else {
            let alert = UIAlertController(
                title: "No Number?:(",
                message: "",
                preferredStyle: .alert)
            present(alert, animated: true)
            
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            
            return
        }

        contactManager.edit(ContactModel(
            name: String(nameField.text ?? ""),
            surname: String(surnameField.text ?? ""),
            phone: String(phoneField.text ?? ""),
            id: id ?? UUID()
        ))
        
        navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
