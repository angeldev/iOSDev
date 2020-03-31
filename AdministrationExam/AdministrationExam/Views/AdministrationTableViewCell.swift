//
//  AdministrationTableViewCell.swift
//  AdministrationExam
//
//  Created by Angel David Macho Esperilla on 29/03/2020.
//  Copyright © 2020 TuLotero. All rights reserved.
//

import UIKit

class AdministrationTableViewCell: UITableViewCell {
    
    //MARK: Properties
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
