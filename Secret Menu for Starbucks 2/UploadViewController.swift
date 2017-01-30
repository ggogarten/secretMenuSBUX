//
//  UploadViewController.swift
//  Secret Menu for Starbucks 2
//
//  Created by George Gogarten on 1/29/17.
//  Copyright © 2017 George Gogarten. All rights reserved.
//

import UIKit
import CoreData


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
