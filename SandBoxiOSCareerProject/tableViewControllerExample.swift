//
//  tableViewControllerExample.swift
//  SandBoxiOSCareerProject
//
//  Created by lionel jones on 10/4/21.
//

import UIKit
import CoreData

class tableViewControllerExample: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var btnAddPerson: UIButton!
    
    
    /*CORE DATA WIREUP*/
    /*Reference to the managed object context */
    /*REMEMBER THE APPDELETE FILE CORE DATA ADDED TO OUR APP DELEGATE - WE ARE ACCESSING IT'S METHOD */
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext;
    
    /*Data for the tableview */
    var items:[Person]?
    
    
    var contacts = ["Ferron Brown",
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
        
        //GET ITEMS FROM CORE DATA
        fetchPeople();
    }
    
    func fetchPeople() {
        //try! context.fetch(Person.fetchRequest());
        do {
            self.items =  try context.fetch(Person.fetchRequest());
            
            /*Do this on the main thread */
            DispatchQueue.main.async {
                self.tableView.reloadData();
            }
            
        } catch{}
    }

    @IBAction func acAddPerson(_ sender: Any) {
        print("You added a person");
        //Create alert
        let alert = UIAlertController(title: "Add Person", message: "What is their name", preferredStyle: .alert);
        alert.addTextField();
        
        //Configure button handler
        let submitButton = UIAlertAction(title: "Add", style: .default) {
            (action) in
            
            //Get the textfield for the alert
            let textfield = alert.textFields![0];
            
            //create a person object to add to core data
            let newPerson = Person(context: self.context);
            newPerson.name = textfield.text;
            newPerson.gender = "Male";
            
            //Save the data to core Data
            try!self.context.save();
            
            
            //Re-fetch the data
            self.fetchPeople();
            
        }
        
        //add the action (submit button action to the alert
        alert.addAction(submitButton);
        //show the alert
        self.present(alert, animated: true, completion: nil);
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
   
    
    /*BELOW ARE SWIPE ACTIONS*/
    /*IOS 15 USES CONTEXTUAL ACTIONS - USE THIS TO NOT HAVE WARNINGS!!!  */
    /*DELETE*/
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
           return UISwipeActionsConfiguration(actions: [
               makeDeleteContextualAction(forRowAt: indexPath)
           ])
       }
    
    private func makeDeleteContextualAction(forRowAt indexPath: IndexPath) -> UIContextualAction {
            return UIContextualAction(style: .destructive, title: "Delete") { (action, swipeButtonView, completion) in
                print("DELETE HERE")
               
                /* This is removing from the original array, will do the core data remove later*/
                self.contacts.remove(at: indexPath.row);
                self.tableView.deleteRows(at: [indexPath], with: .automatic);

                completion(true)
            }
    }
    
    /*UPDATE*/
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
           return UISwipeActionsConfiguration(actions: [
            makeUpdateContextualAction(forRowAt: indexPath)
           ])
       }
    
    private func makeUpdateContextualAction(forRowAt indexPath: IndexPath) -> UIContextualAction {
        return UIContextualAction(style: .normal, title: "Update") { (action, swipeButtonView, completion) in
                print("Updating Here")
                
                print("Updating somethig here....!!")

                completion(true)
            }
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
        //return contacts.count
        return items?.count ?? 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //works with allowing you reuse the cell over and over, the identifier is the name you gave he cell
        //in the storyboard
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        //return the items in our array's values for the text label
        //cell.textLabel?.text = contacts[indexPath.row];
        
        let person = items?[indexPath.row];
        cell.textLabel?.text = person?.name;
        
        return cell;
    }
}




