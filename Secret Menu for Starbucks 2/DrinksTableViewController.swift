//
//  DrinksTableViewController.swift
//  Secret Menu for Starbucks 2
//
//  Created by George Gogarten on 1/29/17.
//  Copyright © 2017 George Gogarten. All rights reserved.
//

import UIKit
import CoreData

class DrinksTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    
    @IBOutlet weak var menuButton: UIBarButtonItem!
   
   
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    // MARK: -
    private let persistentContainer = NSPersistentContainer(name: "Secret_Menu_for_Starbucks_2")
    
    // MARK: -
    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<Drink> = {
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<Drink> = Drink.fetchRequest()
        
        // Configure Fetch Request
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "drinkName", ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "frappuccinos == true")
        
        // Create Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()

    
    override func viewWillAppear(_ animated: Bool) {
//        insertNewDrink()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
        
        persistentContainer.loadPersistentStores { (persistentStoreDescription, error) in
            if let error = error {
                print("Unable to Load Persistent Store")
                print("\(error), \(error.localizedDescription)")
                
            } else {
                self.setupView()
                
                do {
                    try self.fetchedResultsController.performFetch()
                } catch {
                    let fetchError = error as NSError
                    print("Unable to Perform Fetch Request")
                    print("\(fetchError), \(fetchError.localizedDescription)")
                }
                
                self.updateView()
            }
        }
        
          navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 0/255, green: 112/255, blue: 74/255, alpha: 1.0)]
//        self.navigationItem.title = "Coffee"
    
    }
    
    // MARK: - View Methods
    private func setupView() {
        setupMessageLabel()
        
        updateView()
    }
    
    private func updateView() {
        var hasDrinks = false
        
        if let drinks = fetchedResultsController.fetchedObjects {
            hasDrinks = drinks.count > 0
        }
        
        tableView.isHidden = !hasDrinks
//        messageLabel.isHidden = hasQuotes
        
    }
    
    // MARK: -
    private func setupMessageLabel() {
//        messageLabel.text = "You don't drinks yet."
    }
    



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = self.fetchedResultsController.object(at: indexPath)
//                let controller = (segue.destination as! UINavigationController).topViewController as! DrinkDetailViewController
//                // segue.destinationViewController is now segue.destination
                let controller = segue.destination as! DrinkDetailViewController
                controller.detailItem = object
//                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem // self.splitViewController?.displayModeButtonItem() is now self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let drinks = fetchedResultsController.fetchedObjects else { return 0 }
        return drinks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? DrinkTableViewCell else {
            fatalError("Unexpected Index Path")
        }
        
        // Fetch Quote
        let drink = fetchedResultsController.object(at: indexPath)
        
        // Configure Cell
        cell.drinkName.text = drink.drinkName
//        cell.contentsLabel.text = quote.contents
        
        return cell
    }

    func insertNewDrink(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //         UIApplication.shared().delegate as! AppDelegate is now UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let newDrink = NSEntityDescription.insertNewObject(forEntityName: "Drink", into: context)
        
        newDrink.setValue("Frappuccino 2", forKey: "drinkName")
        
        do {
            
            try context.save()
            
            print("Saved")
            
        } catch {
            
            print("There was an error")
            
        }
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Drink")
        
        request.returnsObjectsAsFaults = false
        
        do {
            
            let results = try context.fetch(request)
            
            if results.count > 0 {
                
                for result in results as! [NSManagedObject] {
                    
                    if let username = result.value(forKey: "drinkName") as? String {
                        
                        print(username)
                        
                    }
                    
                }
                
                
            } else {
                
                print("No results")
                
            }
            
            
        } catch {
            
            print("Couldn't fetch results")
            
        }
        
    }
    
    
        
//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }
//    
//    
    

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */


////     Override to support conditional editing of the table view.
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
////         Return false if you do not want the specified item to be editable.
//        return true
//    }
//  
//
//  
////     Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
////             Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
////             Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }    
//    }
    
//    func configureCell(_ cell: UITableViewCell, withEvent event: Drink) {
//        cell.textLabel!.text = event.value(forKey: "drinkName") as? String
//    }
//    
////    var _fetchedResultsController: NSFetchedResultsController<Event>? = nil
//    
//    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        self.tableView.beginUpdates()
//    }
//    
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
//        switch type {
//        case .insert:
//            self.tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
//        case .delete:
//            self.tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
//        default:
//            return
//        }
//    }
//    
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: AnyObject, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//        switch type {
//        case .insert:
//            tableView.insertRows(at: [newIndexPath!], with: .fade)
//        case .delete:
//            tableView.deleteRows(at: [indexPath!], with: .fade)
//       case .update:
//            self.configureCell(tableView.cellForRow(at: indexPath!)!, withEvent: anObject as! Drink)
//        case .move:
//            tableView.moveRow(at: indexPath!, to: newIndexPath!)
//
//    }
//    
//    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        self.tableView.endUpdates()
//    }
        
        
    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
