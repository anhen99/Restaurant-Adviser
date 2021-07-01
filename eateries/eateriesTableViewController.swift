//
//  eateriesTableViewController.swift
//  eateries
//
//  Created by usertest on 23.06.2021.
//

import UIKit
import CoreData

class eateriesTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var fetchResultsController: NSFetchedResultsController<Restaurant>!
    var searchController = UISearchController()
    
    var filteredResultArray: [Restaurant] = []
    var restaurants: [Restaurant] = []
    //      Restaurant(name: "Under Wonder", type: "ресторан", location: "Киев, Большая Васильковская 21", image: "download (1)", isVisited: false),
    //      Restaurant(name: "Любимый Дядя", type: "ресторан", location: "Киев, Паньковская 20", image: "download (2)", isVisited: false),
    //      Restaurant(name: "Прага", type: "ресторан", location: "Киев, Академика Глушкова 1", image: "download (3)", isVisited: false),
    //      Restaurant(name: "Панормама Клаб", type: "ресторан", location: "Киев, Крещатик 1/2", image: "download (4)", isVisited: false),
    //      Restaurant(name: "VINO e CUCINA", type: "ресторан", location: "Киев, Сечевых Стрельцов 82", image: "download (5)", isVisited: false),
    //      Restaurant(name: "Odessa", type: "ресторан-клуб", location: "Киев, Большая Васильковская 114", image: "download (6)", isVisited: false),
    //      Restaurant(name: "Шоти", type: "ресторан", location: "Киев, Мечникова 6", image: "download (7)", isVisited: false),
    //      Restaurant(name: "Coin", type: "ресторан", location: "Киев, Болсуновская 13/15", image: "download (8)", isVisited: false),
    //      Restaurant(name: "Mario", type: "ресторанный комплекс", location: "Киев, Льва Толстого 14а", image: "download (9)", isVisited: false),
    //      Restaurant(name: "NeGorkiy", type: "ресторан", location: "Киев, Антоновичка 74", image: "download (10)", isVisited: false),
    //      Restaurant(name: "Купеческий Двор", type: "ресторан", location: "Киев, Столичное шоссе", image: "download (11)", isVisited: false),
    //      Restaurant(name: "Viila Vita", type: "ресторан", location: "Киев, Вита Поштова", image: "download (12)", isVisited: false),
    //      Restaurant(name: "Fatum", type: "ресторан", location: "Киев, Василия Липковского 16В", image: "download (13)", isVisited: false),
    //      Restaurant(name: "Silk Road", type: "ресторан", location: "Киев, Казимира Малевича 84", image: "download (14)", isVisited: false),
    //      Restaurant(name: "Уголек", type: "ресторан", location:  "Киев, Сагайдачного 35", image: "download (15)", isVisited: false)]
    //
    @IBAction func close(segue: UIStoryboardSegue) { }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnSwipe = true
    }
    
    func filteredContentFor(searchText text: String){
        filteredResultArray = restaurants.filter { (restaurant) -> Bool in
            return (restaurant.name?.lowercased().contains(text.lowercased()))!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.delegate = self
        searchController.searchBar.barTintColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        searchController.searchBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        searchController.searchBar.searchTextField.backgroundColor = .white
        definesPresentationContext = true
        
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        //сreate fetch request with descriptor
        let fetchRequest: NSFetchRequest<Restaurant> = Restaurant.fetchRequest()
        let sortDesccriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDesccriptor]
        
        // getting context
        if let context = (UIApplication.shared.delegate as?AppDelegate)?.coreDataStack.persistentContainer.viewContext{
            //creating fetch result controller
            fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultsController.delegate = self
            
            //trying to retrieve data
            do {
                try fetchResultsController.performFetch()
                
                //save received data in restaurants array
                restaurants = fetchResultsController.fetchedObjects!
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let pageViewController = storyboard?.instantiateViewController(identifier: "pageViewController") as? PageViewController {
            present(pageViewController, animated: true, completion: nil)
        }
    }

    
    // MARK: - Fetch results controller delegate
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert: guard let indexPath = newIndexPath else {break}
            tableView.insertRows(at: [indexPath], with: .fade)
        case .delete: guard let indexPath = indexPath else {break}
            tableView.deleteRows(at: [indexPath], with: .fade)
        case .update: guard let indexPath = indexPath else {break}
            tableView.reloadRows(at: [indexPath], with: .fade)
        default:
            tableView.reloadData()
        }
        restaurants = controller.fetchedObjects as! [Restaurant]
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredResultArray.count
        }
        return restaurants.count
    }
    
    
    func restaurantToDisplayAt(indexPath: IndexPath) -> Restaurant {
        let restaurant: Restaurant
        if searchController.isActive && searchController.searchBar.text != "" {
            restaurant = filteredResultArray[indexPath.row]
            
        } else {
            restaurant = restaurants[indexPath.row]
        }
        return restaurant
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EateriesTableViewCell
        let restaurant = restaurantToDisplayAt(indexPath: indexPath)
        let image = UIImage(data: restaurant.image! as Data)
        cell.imageLabel.image = image
        cell.imageLabel.layer.cornerRadius = 20
        cell.imageLabel.clipsToBounds = true
        cell.nameLabel.text = restaurant.name
        cell.locationLabel.text = restaurant.location
        cell.typeLabel.text = restaurant.type
        cell.accessoryType = restaurant.isVisited ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let share = UITableViewRowAction(style: .default, title: "Поделиться") { (action, IndexPath) in
            let defaultText = "Я сейчас в " + self.restaurants[indexPath.row].name!
            if let image = UIImage(data: self.restaurants[IndexPath.row].image! as Data) {
                let activityController = UIActivityViewController(activityItems: [defaultText, image], applicationActivities: nil)
                self.present(activityController, animated: true, completion: nil)
            }
        }
        
        let delete = UITableViewRowAction(style: .default, title: "Удалить") { (action, IndexPath) in
            self.restaurants.remove(at: indexPath.row)
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext {
                let objectToDelete = self.fetchResultsController.object(at: indexPath)
                context.delete(objectToDelete)
                do {
                    try context.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        
        share.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        delete.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        return[delete, share]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            if let indexPath = tableView.indexPathForSelectedRow{
                let dvc = segue.destination as! EateryDetailViewController
                dvc.restaurant = self.restaurants[indexPath.row]
            }
        }
    }
}

extension eateriesTableViewController: UISearchResultsUpdating{
    func updateSearchResults(for: UISearchController){
        filteredContentFor(searchText: searchController.searchBar.text!)
        tableView.reloadData()
    }
}

extension eateriesTableViewController: UISearchBarDelegate{
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBar.text == "" {
            navigationController?.hidesBarsOnSwipe = false
        }
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        navigationController?.hidesBarsOnSwipe = true
    }
}
