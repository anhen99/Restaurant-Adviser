//
//  EateryDetailTableViewCell.swift
//  eateries
//
//  Created by Anna Zhaglina on 24.06.2021.
//

import UIKit

class EateryDetailTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var keyLabel: UILabel!
    
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
