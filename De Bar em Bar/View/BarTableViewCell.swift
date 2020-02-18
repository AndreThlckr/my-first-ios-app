//
//  BarTableViewCell.swift
//  De Bar em Bar
//
//  Created by Jonathan on 04/02/20.
//  Copyright © 2020 hbsis. All rights reserved.
//

import UIKit

class BarTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingBar: RatingBar!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
