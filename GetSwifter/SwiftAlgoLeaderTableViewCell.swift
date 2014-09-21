//
//  SwiftAlgoLeaderTableViewCell.swift
//  GetSwifter
//
//  Created by Vivek Pandya on 9/21/14.
//  Copyright (c) 2014 Vivek Pandya. All rights reserved.
//

import UIKit

class SwiftAlgoLeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var circularProfileView: CircularProfileView!
    
    
    @IBOutlet weak var handleLabel: UILabel!
    
    @IBOutlet weak var rankLabel: UILabel!
    
    
    @IBOutlet weak var scoreLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
