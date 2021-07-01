//
//  RateViewController.swift
//  eateries
//
//  Created by Anna Zhaglina on 25.06.2021.
//

import UIKit

class RateViewController: UIViewController {
    var restRating: String?
    
    @IBOutlet weak var ratingStackView: UIStackView!
    @IBOutlet weak var badButtom: UIButton!
    @IBOutlet weak var goodButtom: UIButton!
    @IBOutlet weak var brilliantButton: UIButton!
    @IBAction func rateRestaurant(sender: UIButton){
        switch sender.tag {
        case 0: restRating = "bad"
        case 1: restRating = "good"
        case 2: restRating = "brilliant"
        default:
            break
        }
        performSegue(withIdentifier: "unwindSegueToDVC", sender: sender)//осуществляем преход в обратную сторону к detailViewController
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let buttonArray = [badButtom, goodButtom, brilliantButton]
        for (index, button) in buttonArray.enumerated(){
            let delay = Double(index) * 0.2
            UIView.animate(withDuration: 0.6, delay: delay, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
                button?.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        badButtom.transform = CGAffineTransform(scaleX: 0, y: 0)
        goodButtom.transform = CGAffineTransform(scaleX: 0, y: 0)
        brilliantButton.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.view.insertSubview(blurEffectView, at: 1)
    }
}
