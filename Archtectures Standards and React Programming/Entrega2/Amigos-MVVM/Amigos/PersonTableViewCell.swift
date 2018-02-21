//
//  PersonTableViewCell.swift
//  Amigos
//
//  Created by Marcelo Reina on 16/05/17.
//  Copyright © 2017 Marcelo Reina. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var cell: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        profilePicture.layer.cornerRadius = 30.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
