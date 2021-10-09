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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Lets WAR IT";
        
    }
    
    
    @IBAction func playAGame(_ sender: Any) {
        print("Deal tapped!!");
    }
    
    

    @IBAction func dealTapped(_ sender: Any) {
        print("Deal tapped with new connection!!");
    }
}
