//
//  DetailViewController.swift
//  PhoneContacts
//
//  Created by Matus Kivader on 26/10/2023.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    var selectedContact: ContactModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let contactDetail = selectedContact {
            nameLabel.text = "\(contactDetail.name) \(contactDetail.surname)".trimmingCharacters(in: .whitespacesAndNewlines)
            phoneLabel.text = String(contactDetail.phone)
        }
    }
    
    @IBAction func deleteContact(_ sender: Any) {
        let alert = UIAlertController(
            title: "Really?",
            message: "You cant go back!",
            preferredStyle: .alert)
        
        let action = UIAlertAction(
            title: "Delete",
            style: .destructive)
        
        alert.addAction(action)
        present(alert, animated: true)
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
