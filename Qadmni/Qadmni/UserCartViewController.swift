//
//  UserCartViewController.swift
//  Qadmni
//
//  Created by Prakash Sabale on 27/01/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import UIKit

class UserCartViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet var tableview: UITableView!
    
    @IBAction func editCartButton(_ sender: UIButton) {
    }
    
    @IBAction func addMoreButton(_ sender: UIButton) {
    }
    
    @IBAction func proceedToPayButton(_ sender: UIButton) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()

      tableview.delegate = self
      tableview.dataSource = self
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserCartTableViewCell
        return cell
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
