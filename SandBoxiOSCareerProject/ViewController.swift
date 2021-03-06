//
//  ViewController.swift
//  SandBoxiOSCareerProject
//
//  Created by lionel jones on 10/1/21.
//

import UIKit

class ViewController: UIViewController {
    
    private let dataSource = ["Button Image Login Page",
                              "War Game",
                              "Travel Details SQLite3",
                              "Table VC Example"]

    @IBOutlet weak var btnSelectLesson: UIButton!
    @IBOutlet weak var pkvLessonSelect: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Starting the iPhone Application")
        pkvLessonSelect.dataSource = self;
        pkvLessonSelect.delegate = self;
    }


    @IBAction func btnSelectLessonAction(_ sender: Any) {
        let titleValue = btnSelectLesson.titleLabel?.text;
        print(titleValue!);
        
        switch titleValue {
        case "Travel Details SQLite3":
            
            print(" You are going to Travel Details");
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vcTravelDetails = storyboard.instantiateViewController(withIdentifier: "sbdIDTravelDetails")
            self.navigationController!.pushViewController(vcTravelDetails, animated: true)
        
        case "Button Image Login Page":
            
            print(" You are going to Lesson - Button Image Login Page");
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vcLoginPage = storyboard.instantiateViewController(withIdentifier: "sbIDLoginPage")
            self.navigationController!.pushViewController(vcLoginPage, animated: true)
            
        case "War Game":
            print(" You are going to Lesson - Button Image Login Page");
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vcWarGame = storyboard.instantiateViewController(withIdentifier: "sbIDWarGameVC")
            self.navigationController!.pushViewController(vcWarGame, animated: true)
           
        case "Table VC Example":
            print(" Yoy are to to Table View Controller");
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vcTableVC = storyboard.instantiateViewController(withIdentifier: "sbIDTableVC")
            self.navigationController!.pushViewController(vcTableVC, animated: true)
        
        default:
            print("You are not  going anywhere...")
        }
        
        
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count;
    }
    
    //how many columns
    func numberOfComponents(in pkvLessonSelect: UIPickerView) -> Int {
       return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("You selected the lesson \(dataSource[row])");
        btnSelectLesson.setTitle(dataSource[row],for: .normal);
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //title for the row in the picker view
        return dataSource[row]
    }
}

