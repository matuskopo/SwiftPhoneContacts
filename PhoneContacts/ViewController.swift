//
//  ViewController.swift
//  PhoneContacts
//
//  Created by Matus Kivader on 25/10/2023.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    @IBOutlet weak var sgmUI: UISegmentedControl!
    @IBOutlet weak var sgmDataSource: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Phone Contacts"
    }

    @IBAction func doStart(_ sender: Any) {
        if sgmDataSource.selectedSegmentIndex == 0 {
            Resources.sharedInstance.dataManager = JSONContactsManager()
        } else if sgmDataSource.selectedSegmentIndex == 1 {
            Resources.sharedInstance.dataManager = CoreDataContactsManager()
        } else {
            Resources.sharedInstance.dataManager = FirebaseContactsManager()
        }
        
        if sgmUI.selectedSegmentIndex == 0 {
            performSegue(withIdentifier: "segueShowUIKit", sender: nil)
        } else if sgmUI.selectedSegmentIndex == 1 {
            performSegue(withIdentifier: "segueShowSwiftUI", sender: nil)
        } else {
            performSegue(withIdentifier: "segueShowM2UI", sender: nil)
        }
    }
    
    
    @IBSegueAction func loadSwiftUIView(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: ContactListView())
    }
    
    @IBSegueAction func loadM2UIView(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: ContactListM2View())
    }
}

