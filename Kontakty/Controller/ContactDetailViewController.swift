//
//  ContactDetailViewController.swift
//  Kontakty
//
//  Created by Michał Massloch on 12/03/2022.
//

import UIKit

class ContactDetailViewController: UITableViewController {

    @IBOutlet weak var imageLarge: UIImageView!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var numbersCellLabel: UILabel!
    @IBOutlet weak var numbersPhoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var adressStreetAndNumberLabel: UILabel!
    @IBOutlet weak var adressCityLabel: UILabel!
    @IBOutlet weak var adressCountryLabel: UILabel!
    
    var contact: Result? {
        didSet {
            refreshUI()
        }
    }
    
    private func refreshUI() {
       
        loadViewIfNeeded()
        if let contactLastName = contact?.name.last, let contactFirstName = contact?.name.first {
            lastNameLabel.text = contactLastName
            firstNameLabel.text = contactFirstName
        }
        if let contactCellNumber = contact?.cell, let contactPhoneNumber = contact?.phone {
            numbersCellLabel.text = contactCellNumber
            numbersPhoneLabel.text = contactPhoneNumber
        }
        if let contactEmail = contact?.email {
            emailLabel.text = contactEmail
        }
        
        if let number = contact?.location.street.numberString, let street = contact?.location.street.name, let city = contact?.location.city , let country = contact?.location.country {
            
            adressStreetAndNumberLabel.text = (street + " " + number)
            adressCityLabel.text = city
            adressCountryLabel.text = country
        }
        

        if let safeUrl = URL(string: contact?.picture.large ?? "error") {
            let data = try? Data(contentsOf: safeUrl)
             
                if let safeData = data {
                    DispatchQueue.main.async {
                        self.imageLarge.image = UIImage(data: safeData)
                    }
                }
        }
        tableView.reloadData()

    }
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        imageLarge.layer.cornerRadius = imageLarge.frame.size.height/2
        imageLarge.layer.masksToBounds = true
        imageLarge.layer.borderWidth = 0
        refreshUI()

    }

}

extension ContactDetailViewController: ContactSelectionDelegate {
    func contactSelected(_ newContact: Result) {
        self.contact = newContact
        
    }
}
