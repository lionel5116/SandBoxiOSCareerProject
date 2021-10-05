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
        
        //let _name: String = "David Jones";
        //let _country: String = "SJO";
        //let _budget: Double = 76000.00;
        
        var _lstTD : [TravelDetails] = [];
        
        var my_DB : OpaquePointer? = nil;
        my_DB = createSQLiteDatabase();  //create the database first to get the database pointer
        //self.createTable(_db:my_DB);
        //self.insertData(name:_name,country:_country,budget:_budget,_db:my_DB,list:_lstTD);
        _lstTD = self.readDB(_db:my_DB);
        print(_lstTD[0].name!);
        print(_lstTD[0].country!);
        print(_lstTD[0].budget);
        
        //sqlite3_close(my_DB); //close the database
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
        
        
        
        //create a table for our sqlite database
        let createTableQuery = "CREATE TABLE IF NOT EXISTS TravelDetails (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, country TEXT, budget REAL)";
        //execute the query
        if sqlite3_exec(_db, createTableQuery,nil,nil,nil) != SQLITE_OK {
            print("Error creating table for travel details")
        }
        else {
            print("Creation of table sucess!!!");
            //insertData(name:_name,country:_country,budget:_budget,_db:_db);
        }
    }
    
    func insertData(name: String, country: String, budget: Double,_db: OpaquePointer?,list: [TravelDetails]) {
        //https://www.youtube.com/watch?v=2v0vY-u4ItA
        //we have already inserted firsr record with ID, don't neeed to insert subsequent with id, it is auto increment
        //let query = "INSERT INTO TravelDetails (id,name,country,budget) VALUES (?,?,?,?)";
        let query = "INSERT INTO TravelDetails (name,country,budget) VALUES (?,?,?)";
        var statement : OpaquePointer? = nil;
        if sqlite3_prepare_v2(_db,query, -1, &statement, nil) == SQLITE_OK {
            //we have already inserted firsr record with ID, don't neeed to insert subsequent
            //sqlite3_bind_int(statement,1,1);
            sqlite3_bind_text(statement,1, (name as NSString).utf8String,-1,nil);
            sqlite3_bind_text(statement,2, (country as NSString).utf8String,-1,nil);
            sqlite3_bind_double(statement,3,budget);
            
            //print("Query for Insert Successful!!!");
            
            let data = try! JSONEncoder().encode(list)
            let listString = String(data:data, encoding: .utf8);
            sqlite3_bind_text(statement, 5, (listString! as NSString).utf8String, -1,nil);
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Data inserted successfully!!!");
            }
            else{
                print("Data did not insert successfully!!!");
            }
        }
        else {
            print("Query is not valid!!!");
        }
    }
    
    func readDB(_db: OpaquePointer?) -> [TravelDetails] {
        var _list = [TravelDetails]();
        let query = "SELECT name,country,budget FROM TravelDetails";
        var statement : OpaquePointer? = nil;
        if sqlite3_prepare_v2(_db,query, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                let _name = String(cString: sqlite3_column_text(statement,0));
                let _country = String(cString :sqlite3_column_text(statement,1));
                let _budget = Double(sqlite3_column_double(statement,2));
                
                let model = TravelDetails();
                model.name = _name;
                model.country = _country;
                model.budget = _budget;
                _list.append(model);
            }
        }
        return _list;
    }
}
