//
//  DrinkDetailViewController.swift
//  Secret Menu for Starbucks 2
//
//  Created by George Gogarten on 1/29/17.
//  Copyright © 2017 George Gogarten. All rights reserved.
//

import UIKit

class DrinkDetailViewController: UIViewController {

    
    @IBAction func backButtonPress(_ sender: Any) {
    }
    
    
    @IBOutlet weak var drinkNameLabel: UILabel!
    
    
    func configureView() {
        // Update the user interface for the detail item.
        
        if let detail = self.detailItem {
            
            print(detail.value(forKey: "drinkName"))
//            self.title = detail.value(forKey: "drinkName") as! String
//            
            
            DispatchQueue.main.async {
                self.drinkNameLabel.text = detail.value(forKey: "drinkName") as! String
                
            }
            
            }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//         self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var detailItem: Drink? {
        didSet {
            // Update the view.
            self.configureView()
        }
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
