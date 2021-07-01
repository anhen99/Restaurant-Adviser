//
//  eateriesTableViewCell.swift
//  eateries
//
//  Created by usertest on 23.06.2021.
//

import UIKit

class EateriesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
