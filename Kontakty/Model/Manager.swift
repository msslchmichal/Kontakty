//
//  Manager.swift
//  Kontakty
//
//  Created by Michał Massloch on 11/03/2022.
//

import Foundation

protocol ManagerDelegate {
    func didUpdateContacts(contact: [Result])
    func didFailedWithError(error: Error)
}

struct Manager {
    
    let contactsURL = "https://api.randomuser.me/?results=500&key=0A4F-FC2E-5C76-5678&seed=rekrutacja2022"
    
    var delegate: ManagerDelegate?
    
    func fetchContacts() {
        let urlString = contactsURL
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    delegate?.didFailedWithError(error: error!)
                }
                if let safeData = data {
                    parseJSON(contactData: safeData)
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(contactData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(Contact.self, from: contactData)
            self.delegate?.didUpdateContacts(contact: decodedData.results)
        }
        catch {
            delegate?.didFailedWithError(error: error)
            print(error)
        }
    }
    
}
