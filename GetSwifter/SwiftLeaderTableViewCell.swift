//
//  SwiftLeaderTableViewCell.swift
//  GetSwifter
//

//

import UIKit

class SwiftLeaderTableViewCell: UITableViewCell {
    
    

    
    @IBOutlet weak var handleLabel: UILabel!

    @IBOutlet weak var rankLabel: UILabel!
    
    
    @IBOutlet weak var circularProfileView: CircularProfileView!
    
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
