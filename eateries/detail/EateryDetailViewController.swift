//
//  EateryDetailViewController.swift
//  eateries
//
//  Created by Anna Zhaglina on 24.06.2021.
//

import UIKit

class EateryDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var test3: UIButton! // кнопка Rate button
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue){
        guard let sourceViewController = segue.source as? RateViewController else {return}
        guard let rating = sourceViewController.restRating else { return  }
        test3.setImage(UIImage(named: rating), for: .normal)
    }
    
    var restaurant: Restaurant?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttons = [test3, mapButton] // test3 = rateButton
        for button in buttons{
            guard let button = button else { break }
            button.layer.cornerRadius = 5
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.white.cgColor // кнопка переключатель вью контроллеров стретьего раза получилась
            
        }
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        title = restaurant!.name
        
        imageView.image = UIImage(data: restaurant!.image! as Data)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EateryDetailTableViewCell
        switch indexPath.row {
        case 0:
            cell.keyLabel.text = "Название"
            cell.valueLabel.text = restaurant!.name
        case 1:
            cell.keyLabel.text = "Тип ресторана"
            cell.valueLabel.text = restaurant!.type
        case 2:
            cell.keyLabel.text = "Адрес"
            cell.valueLabel.text = restaurant!.location
        case 3:
            cell.keyLabel.text = "Я там был"
            cell.valueLabel.text = restaurant!.isVisited ? "Да" : "Нет"
        default:
            break
        }
        
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapSegue"  {
            let destinationViewController = segue.destination as! MapViewController
            destinationViewController.restaurant = self.restaurant
        }
    }
    
}
