//
//  ViewController.swift
//  Kontakty
//
//  Created by Michał Massloch on 11/03/2022.
//

import UIKit

protocol ContactSelectionDelegate: AnyObject {
    func contactSelected(_ newContact: Result)
}

class TableViewController: UITableViewController, ManagerDelegate {
    
   
    
    func didUpdateContacts(contact: [Result]) {
        print("indidUpdateContacts")
        
        self.contactArray = contact
       
        contactArray.sort{
            ($0.name.last, $0.name.first) < ($1.name.last,$1.name.first)
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFailedWithError(error: Error) {
        print(error)
    }
    
    let myActivityIndicator = UIActivityIndicatorView(style:.medium)
    
    var contactArray = [Result]()
    var contactManager = Manager()
    
    weak var delegate: ContactSelectionDelegate?

    override func viewDidLoad() {
        print("in VC viewDidLoad")
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        contactManager.delegate = self
        contactManager.fetchContacts()
        myActivityIndicator.center = view.center
        myActivityIndicator.hidesWhenStopped = true
        view.addSubview(myActivityIndicator)
        myActivityIndicator.startAnimating()
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("contactArray.count \(contactArray.count)")
        return contactArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.myActivityIndicator.stopAnimating()
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell") as! ContactTableViewCell
            
            cell.lastNameLabel.text = (contactArray[indexPath.row].name.last + " " + contactArray[indexPath.row].name.first)
        let url = URL(string: contactArray[indexPath.row].picture.thumbnail)
//        if url != nil {
//            let data = try? Data(contentsOf: url!)
//            DispatchQueue.main.async {
//                if data != nil {
//                    cell.imageThumbnail.image = UIImage(data: data!)
//                }
//            }
//        }
//
        if let safeUrl = url {
            let data = try? Data(contentsOf: safeUrl)
            DispatchQueue.main.async {
                if let safeData = data {
                    cell.imageThumbnail.image = UIImage(data: safeData)
                }
            }
        }
        
        
        
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedContact = contactArray[indexPath.row]
        print(selectedContact)
        delegate?.contactSelected(selectedContact)
        if let detailVC = delegate as? ContactDetailViewController, let detailNavigationController = detailVC.navigationController {
            splitViewController?.showDetailViewController(detailNavigationController, sender: nil)
        }
    }
}

