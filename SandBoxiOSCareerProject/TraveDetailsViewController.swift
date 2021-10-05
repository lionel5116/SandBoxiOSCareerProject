//
//  TraveDetailsViewController.swift
//  SandBoxiOSCareerProject
//
//  Created by lionel jones on 10/1/21.
//

import UIKit
import SQLite3

//https://www.youtube.com/watch?v=Z2CG-p91MpI

class TravelDetails: Codable {
    var name: String?
    var country: String?
    var budget: Double = 0.00
}

class TraveDetailsViewController: UIViewController {

    var db: OpaquePointer? = nil;
    var path: String = "TravelDB.sqlite";
    
    @IBOutlet weak var btnCreateDatabase: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TD Create SQLite DB";
    }
    
    @IBAction func acCreateDatabase(_ sender: Any) {
        
        //createSQLiteDatabase();
        var my_DB : OpaquePointer? = nil;
        my_DB = createSQLiteDatabase();
        self.createTable(_db:my_DB);
    }
    
    func createSQLiteDatabase() -> OpaquePointer? {
       //https://www.youtube.com/watch?v=Z2CG-p91MpI
        
        let filePath = try! FileManager.default.url(for: .documentationDirectory, in: .userDomainMask, appropriateFor: nil, create:
                                                        false).appendingPathExtension(path)
        
        var db: OpaquePointer? = nil;
        //try to open sqlite file
        if sqlite3_open(filePath.path, &db) != SQLITE_OK {
            print("Error openining SQLite Database file");
            return nil;
        }
        else{
            return db
        }
    }
    
    func createTable(_db: OpaquePointer?) {
        
        let _name: String = "David Jones";
        let _country: String = "SJO";
        let _budget: Double = 76000.00;
        
        //create a table for our sqlite database
        let createTableQuery = "CREATE TABLE IF NOT EXISTS TravelDetails (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, country TEXT, budget REAL)";
        //execute the query
        if sqlite3_exec(_db, createTableQuery,nil,nil,nil) != SQLITE_OK {
            print("Error creating table for travel details")
        }
        else {
            print("Creation of table sucess!!!");
            insertData(name:_name,country:_country,budget:_budget,_db:_db);
        }
    }
    
    func insertData(name: String, country: String, budget: Double,_db: OpaquePointer?) {
        //https://www.youtube.com/watch?v=2v0vY-u4ItA
        let query = "INSERT INTO TravelDetails (name,country,budget) VALUES (?,?,?)";
        var statement : OpaquePointer? = nil;
        if sqlite3_prepare_v2(_db,query, -1, &statement, nil) == SQLITE_OK {
            print("Query for Insert Successful!!!");
        }
        else {
            print("Query is not valid!!!");
        }
    }
}
