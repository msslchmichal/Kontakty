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
        print("fetchContacts")
        let urlString = contactsURL
        //print(urlString)
        performRequest(with: urlString)
    }
    func performRequest(with urlString: String){
        print("in performRequest")
        if let url = URL(string: urlString) {
            print("in if let url")
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    delegate?.didFailedWithError(error: error!)
                    
                }
                if let safeData = data {
                    print("in if let safeData")
                    parseJSON(contactData: safeData)
                }
            }
            task.resume()
        }
        
    }
    
    func parseJSON(contactData: Data) {
        print("in parseJSON")
        let decoder = JSONDecoder()
        do {
            print("in parseJSON do")
            let decodedData = try decoder.decode(Contact.self, from: contactData)
            //print(decodedData.results)
            self.delegate?.didUpdateContacts(contact: decodedData.results)
         
//            let name = decodedData.results[0].name.first
//            let contact = ContactModel(firstName: name, lastName: "", cityName: "", streetName: "", houseNumber: 0, emailAdress: "", phoneNumber: "", cellNumber: "")
            //return contact
        }
        catch {
            delegate?.didFailedWithError(error: error)
            //return nil
            print(error)
        }
    }
    
}
