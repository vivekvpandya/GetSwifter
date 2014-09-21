//
//  ChallengeDetailsTableViewCell.swift
//  GetSwifter
//
//  Created by Vivek Pandya on 9/21/14.
//  Copyright (c) 2014 Vivek Pandya. All rights reserved.
//

import UIKit

class ChallengeDetailsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var challenge: UILabel!
    
    
    @IBOutlet weak var platformLabel: UILabel!
    @IBOutlet weak var technologyLabel: UILabel!

    @IBOutlet weak var subEndLabel: UILabel!
    @IBOutlet weak var regEndLabel: UILabel!
    
    
    @IBOutlet weak var submissionsLabel: UILabel!
    @IBOutlet weak var registrantsLabel: UILabel!
    
    
    @IBOutlet weak var totalPrize: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
