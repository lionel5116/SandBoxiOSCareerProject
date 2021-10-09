//
//  WarCardGameViewController.swift
//  SandBoxiOSCareerProject
//
//  Created by lionel jones on 10/3/21.
//

import UIKit

class WarCardGameViewController: UIViewController {
    
    
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    
    @IBOutlet weak var leftScoreLabel: UILabel!
    @IBOutlet weak var rightScoreLabel: UILabel!
    
    @IBOutlet weak var btnGamePlayButton: UIButton!
    
    var _leftScore = 0;
    var _rightScore = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Lets WAR IT";
        
    }
    
    
    @IBAction func playAGame(_ sender: Any) {
        print("Deal tapped!!");
    }
    
    

    @IBAction func dealTapped(_ sender: Any) {
       
        let leftNumber = Int.random(in: 2...14);
        let rightNumber = Int.random(in: 2...14);
       
        print("left hand \(leftNumber)");
        print("right hand \(rightNumber)");
        
        /*
        let leftRand = "card" + "" + String(leftNumber);
        let  rightRand = "card" + "" + String(RightNumber);
        */
        
        leftImageView.image = UIImage(named: "card\(leftNumber)");
        rightImageView.image = UIImage(named: "card\(rightNumber)");
        
        if leftNumber > rightNumber {
            _leftScore += 1;
            leftScoreLabel.text = String(_leftScore);
           
        }
        else if rightNumber >  leftNumber {
            _rightScore += 1;
            rightScoreLabel.text = String(_rightScore);
     
        }
        else {
            
        }
    }
}
