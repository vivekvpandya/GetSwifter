//
//  CompletedChallengeTableViewCell.swift
//  GetSwifter
//
//  Created by Vivek Pandya on 9/20/14.
//  Copyright (c) 2014 Vivek Pandya. All rights reserved.
//

import UIKit

class CompletedChallengeTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var challengeTitle: UILabel!
    
    @IBOutlet weak var registrantsLabel: UILabel!
    
    
    @IBOutlet weak var numSubmissionLabel: UILabel!
    
    @IBOutlet weak var totalPrizeLabel: UILabel!
    
    @IBOutlet weak var subEndDateLabel: UILabel!
    
    @IBOutlet weak var technologyLabel: UILabel!

    @IBOutlet weak var platformlLabel: UILabel!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
