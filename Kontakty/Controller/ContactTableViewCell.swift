//
//  ContactTableViewCell.swift
//  Kontakty
//
//  Created by Michał Massloch on 11/03/2022.
//

import UIKit

class ContactTableViewCell: UITableViewCell {


    @IBOutlet weak var imageThumbnail: UIImageView!
    @IBOutlet weak var lastNameLabel: UILabel!

        override func awakeFromNib() {
        super.awakeFromNib()
            imageThumbnail.layer.cornerRadius = imageThumbnail.frame.size.height/2
            imageThumbnail.layer.masksToBounds = true
            imageThumbnail.layer.borderWidth = 0
     
    }

}
