//
//  LevelCompletedViewController.swift
//  LineRiderGame
//
//  Created by David Guichon on 2017-04-22.
//  Copyright © 2017 KSG. All rights reserved.
//

import Foundation
import UIKit

class LevelCompleteViewController: UIViewController {
    
    @IBOutlet var congratulationsView: UIView!
    @IBOutlet var scoreLabel: UILabel!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        congratulationsView.layer.borderWidth = 1.0
        congratulationsView.layer.borderColor = UIColor.red.cgColor
        congratulationsView!.isHidden = false
    }
    
    @IBAction func nextLevel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
//        performSegue(withIdentifier: "NextLevel", sender: sender)
    }

    
}
