//
//  ContentViewController.swift
//  eateries
//
//  Created by Anna Zhaglina on 01.07.2021.
//

import UIKit

class ContentViewController: UIViewController {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var subheaderLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var header = ""
    var subheader = ""
    var imageFile = ""
    var index = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerLabel.text = header
        subheaderLabel.text = subheader
        imageView.image = UIImage(named: imageFile)
    }
}
