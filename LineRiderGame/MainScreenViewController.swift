//
//  MainScreenViewController.swift
//  LineRiderGame
//
//  Created by David Guichon on 2017-04-23.
//  Copyright © 2017 KSG. All rights reserved.
//

import Foundation
import UIKit

class MainScreenViewController: UIViewController {
    
//    var levelManager: LevelManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        levelManager = LevelManager()
    }
    
    @IBAction func startCurrentLevel(_ sender: UIButton) {
//        performSegue(withIdentifier: "StartGame", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StartGame" {
//            let gameVC = segue.destination as! GameViewController
//            gameVC.levelManager = levelManager
        }
    }
    
}
