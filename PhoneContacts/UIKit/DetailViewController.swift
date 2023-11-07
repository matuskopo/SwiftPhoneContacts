//
//  DetailViewController.swift
//  PhoneContacts
//
//  Created by Matus Kivader on 26/10/2023.
//

import UIKit
import MessageUI

class DetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var initialsLabel: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
        
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var phoneNumberStack: UIStackView!
    
    var selectedContact: ContactModel?
    let contactManager = Resources.sharedInstance.dataManager
    
    weak var refreshDelegate: RefreshDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Picture rounding
        profilePicture.layer.cornerRadius = profilePicture.frame.size.width / 2
        profilePicture.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        contactManager.load { [weak self] returnedArray in
            self?.selectedContact = returnedArray.filter({ $0.id == self?.selectedContact?.id }).first
            
            if let contactDetail = self?.selectedContact {
                self?.initialsLabel.text = "\((contactDetail.name.prefix(1)).uppercased() + (contactDetail.surname.prefix(1)).uppercased())".trimmingCharacters(in: .whitespacesAndNewlines)
                self?.nameLabel.text = "\(contactDetail.name) \(contactDetail.surname)".trimmingCharacters(in: .whitespacesAndNewlines)
                self?.phoneLabel.text = String(contactDetail.phone)
            }
        }
    }
    
    @IBAction func editContact(_ sender: Any) {
        if let editVC = storyboard?.instantiateViewController(withIdentifier: "Edit") as? EditContactController {
            editVC.name = selectedContact?.name
            editVC.surname = selectedContact?.surname
            editVC.phone = selectedContact?.phone
            editVC.id = selectedContact?.id
            
            navigationController?.pushViewController(editVC, animated: true)
        }
    }
    
    @IBAction func deleteContact(_ sender: Any) {
        let alert = UIAlertController(
            title: "Really?",
            message: "You cant go back!",
            preferredStyle: .alert)
        
        let action = UIAlertAction(
            title: "Delete",
            style: .destructive,
            handler: { _ in
                if let contact = self.selectedContact {
                    self.contactManager.delete(contact)
                    
                    self.refreshDelegate?.refreshData()
                    self.navigationController?.popViewController(animated: true)
                }})
        
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "Nope!", style: .cancel))
        present(alert, animated: true)
    }
    
    @IBAction func callContact(_ sender: Any) {
        composeURL(applicationShortcut: "tel://")
    }
    
    @IBAction func messageContact(_ sender: Any) {
        composeURL(applicationShortcut: "sms:")
    }
    
    @IBAction func mailContact(_ sender: Any) {
        composeURL(applicationShortcut: "mailto:")
    }
    
    @IBAction func facetimeContact(_ sender: Any) {
        composeURL(applicationShortcut: "facetime://")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Private methods
    
    private func composeURL(applicationShortcut: String) {
        var urlParameter: String
        if applicationShortcut == "mailto:" {
            urlParameter = ""
        } else {
            urlParameter = selectedContact?.phone ?? ""
        }
        
        guard let phoneNumber = URL(string: applicationShortcut + urlParameter) else { return }
        if UIApplication.shared.canOpenURL(phoneNumber) {
            UIApplication.shared.open(phoneNumber)
        } else {
            print("Can't open url on this device")
        }
    }

}
