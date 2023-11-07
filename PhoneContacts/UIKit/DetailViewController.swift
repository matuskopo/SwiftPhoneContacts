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
    @IBOutlet weak var profilePicture: UIImageView!
    
    var selectedContact: ContactModel?
    let contactManager = Resources.sharedInstance.dataManager
    
    weak var refreshDelegate: RefreshDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profilePicture.layer.cornerRadius = profilePicture.frame.size.width / 2
        profilePicture.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        contactManager.load { [weak self] returnedArray in
            self?.selectedContact = returnedArray.filter({ $0.id == self?.selectedContact?.id }).first
            
            if let contactDetail = self?.selectedContact {
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
