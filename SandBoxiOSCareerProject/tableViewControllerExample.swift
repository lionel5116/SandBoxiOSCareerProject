//
//  tableViewControllerExample.swift
//  SandBoxiOSCareerProject
//
//  Created by lionel jones on 10/4/21.
//

import UIKit

class tableViewControllerExample: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    let contacts = ["Ferron Brown",
                    "Mark Tyson",
                    "Dac Black",
                    "Rick James"]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Table VC IT!!!!";
        // Do any additional setup after loading the view.
        
        //assign the delegate and datasource for our tableview
        tableView.delegate = self;
        tableView.dataSource = self;
    }

}


extension tableViewControllerExample: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tapped me")
    }
}

extension tableViewControllerExample: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //return our array of items .count
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //works with allowing you reuse the cell over and over, the identifier is the name you gave he cell
        //in the storyboard
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        //return the items in our array's values for the text label
        cell.textLabel?.text = contacts[indexPath.row];
        
        return cell;
    }
}


