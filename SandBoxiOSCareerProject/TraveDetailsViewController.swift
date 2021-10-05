//
//  TraveDetailsViewController.swift
//  SandBoxiOSCareerProject
//
//  Created by lionel jones on 10/1/21.
//

import UIKit
import SQLite3

class TraveDetailsViewController: UIViewController {

    var path: String = "TravelDB.sqlite";
    
    @IBOutlet weak var btnCreateDatabase: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TD Create SQLite DB";
    }
    
    @IBAction func acCreateDatabase(_ sender: Any) {
        createSQLiteDatabase();
    }
    
    func createSQLiteDatabase() {
        
       //https://www.youtube.com/watch?v=Z2CG-p91MpI
        
        let filePath = try! FileManager.default.url(for: .documentationDirectory, in: .userDomainMask, appropriateFor: nil, create:
                                                        false).appendingPathExtension(path)
        
        var db: OpaquePointer? = nil;
        //try to open sqlite file
        if sqlite3_open(filePath.path, &db) != SQLITE_OK {
            print("Error openining SQLite Database file");
        }
        
        //create a table for our sqlite database
        let createTableQuery = "CREATE TABLE IF NOT EXISTS TravelDetails (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, country TEXT, budget REAL)";
        
        
        //execute the query
        if sqlite3_exec(db, createTableQuery,nil,nil,nil) != SQLITE_OK {
            print("Error creating table for travel details")
            return;
        }
        
        print("Creation of database and tables is successful");
    }

}
