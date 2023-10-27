//
//  AddContactViewController.swift
//  PhoneContacts
//
//  Created by Matus Kivader on 26/10/2023.
//

import UIKit

class AddContactViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var surnameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    
    var contactManager = Resources.sharedInstance.dataManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addContact(_ sender: Any) {
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

        contactManager.add(ContactModel(
            name: String(nameField.text ?? ""),
            surname: String(surnameField.text ?? ""),
            phone: String(phoneField.text ?? "")
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
