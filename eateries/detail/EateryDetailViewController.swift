//
//  EateryDetailViewController.swift
//  eateries
//
//  Created by Anna Zhaglina on 24.06.2021.
//

import UIKit

class EateryDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
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
    
    @IBAction func knopka(_ sender: UIButton) {
    }
    //    @IBAction func rateButton(_ sender: UIButton) {
//    }
    @IBOutlet weak var test3: UIButton!
    @IBOutlet weak var rateButtom: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    var restaurant: Restaurant?
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue){
    }
    //    override func viewWillAppear(_ animated: Bool) {
//        navigationController?.hidesBarsOnSwipe = false
//        navigationController?.setNavigationBarHidden(false, animated: true)
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        test3.layer.cornerRadius = 5
        test3.layer.borderWidth = 1
        test3.layer.borderColor = UIColor.white.cgColor // кнопка переключатель вью контроллеров стретьего раза получилась
        
//        rateButtom.layer.cornerRadius = 5
//        rateButtom.layer.borderWidth = 1
//        rateButtom.layer.borderColor = UIColor.white.cgColor

//        tableView.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
//        tableView.separatorColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        title = restaurant!.name

        imageView.image = UIImage(named: restaurant!.image)
        
        
    }
    
    
    
    
}
