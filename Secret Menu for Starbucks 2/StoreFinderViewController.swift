//
//  StoreFinderViewController.swift
//  Secret Menu for Starbucks 2
//
//  Created by George Gogarten on 1/29/17.
//  Copyright © 2017 George Gogarten. All rights reserved.
//

import UIKit

class StoreFinderViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
   
  
    @IBAction func refreshButton(_ sender: Any) {
        webView.reload()
    }
    
    @IBOutlet weak var webView: UIWebView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        }
       
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 0/255, green: 112/255, blue: 74/255, alpha: 1.0)]

        webView.loadRequest(NSURLRequest(url: NSURL(string: "https://www.loxcel.com/sbux")! as URL) as URLRequest)
        
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
