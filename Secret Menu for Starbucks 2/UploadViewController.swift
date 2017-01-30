//
//  UploadViewController.swift
//  Secret Menu for Starbucks 2
//
//  Created by George Gogarten on 1/29/17.
//  Copyright © 2017 George Gogarten. All rights reserved.
//

import UIKit
import CoreData
import Foundation


class UploadViewController: UIViewController {
    
    
    @IBAction func uploadButtonPress(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate // UIApplication.shared().delegate as! AppDelegate is now UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        //        let newDrink = NSEntityDescription.insertNewObject(forEntityName: "Drink", into: context)
        //
        //        newDrink.setValue("Frappuccino 1", forKey: "drinkName")
        //
        //        do {
        //
        //            try context.save()
        //
        //            print("Saved")
        //
        //        } catch {
        //
        //            print("There was an error")
        //
        //        }
        
        
        
        
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Drink")
        
        request.returnsObjectsAsFaults = false
        
        do {
            
            let results = try context.fetch(request)
            
            if results.count > 0 {
                
                for result in results as! [NSManagedObject] {
                    
                    if let name = result.value(forKey: "drinkName") as? String {
                        
                        print(name)
                        
                    }
                    
                }
                
                
            } else {
                
                print("No results")
                
            }
            
            
        } catch {
            
            print("Couldn't fetch results")
            
        }
        
        
        let jsonURL = Bundle.main.url(forResource: "test", withExtension: "json")!
        let jsonData = NSData(contentsOf: jsonURL)
        if let content = jsonData {
            
            do {
                
                let jsonResult = try JSONSerialization.jsonObject(with: content as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                //        let jsonResult = try JSONSerialization.
                print("printing json result")
                print(jsonResult)
                
                if let items = jsonResult as? NSArray {
//                    let context = self.fetchedResultsController.managedObjectContext
                    print("json unpacking")
//                      let context = persistentContainer.viewContext
                    
                    let request = NSFetchRequest<Drink>(entityName: "Drink")
                    for item in items as [AnyObject] {
                        print("printing name")
                        print(item["drinkName"])
                        
                        print(item["recipe"])
                        
                        print(item["frappuccino"])
                        
                        
                        let newEvent = Drink(context: context)
                        
                        
                        // If appropriate, configure the new managed object.
//                        newEvent.timeStamp = NSDate()
                        newEvent.setValue(item["drinkName"] as! String, forKey: "drinkName")
//                        newEvent.setValue(item["title"] as! String, forKey: "title")
//                        newEvent.setValue(item["content"] as! String, forKey: "content")
                        
                        // Save the context.
                        do {
                            try context.save()
                        } catch {
                            // Replace this implementation with code to handle the error appropriately.
                            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                            let nserror = error as NSError
                            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                        }
                        
                        
                    }
                    
//                    self.tableView.reloadData()
                    
                }
                
            } catch {
                
                print("JSON Processing Failed")
                
            }
            
            
            
            
            
            
        }
        
//        task.resume()
        
    }
    
    
    
    
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
