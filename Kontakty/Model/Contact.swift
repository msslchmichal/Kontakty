//
//  Contact.swift
//  Kontakty
//
//  Created by Michał Massloch on 11/03/2022.
//

import Foundation

struct Contact: Codable {
    let results: [Result]
    
}
struct Result: Codable {
    let name: Name
    let location: Location
    let email: String
    let phone: String
    let cell: String
    let picture: Picture
}
struct Name: Codable {
    let first: String
    let last: String
}

struct Location: Codable {
    let street: Street
    let city: String
    let country: String
    
}

struct Street: Codable {
    let number: Int
    let name: String
    
    var numberString: String {
        return String(format: "%d", number)
    }
    
}
struct Picture: Codable {
    let large: String
    let medium: String
    let thumbnail: String
}
