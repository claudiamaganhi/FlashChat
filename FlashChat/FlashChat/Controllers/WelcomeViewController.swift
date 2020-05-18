//
//  ViewController.swift
//  FlashChat
//
//  Created by Claudia Cavalini Maganhi on 13/05/20.
//  Copyright © 2020 Claudia Cavalini Maganhi. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animateTitle()
    }

    @IBAction func register(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(identifier: Constants.registerStoryboardID) as? RegisterViewController else {
            print("Failed to load RegisterViewController from storyboard.")
            return
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func login(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(identifier: Constants.loginStoryboardID) as? LoginViewController else {
            print("Failed to load LoginViewController from storyboard.")
            return
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func animateTitle() {
        let title = Constants.appName
        titleLabel.text = ""
        
        for (index, letter) in title.enumerated() {
            Timer.scheduledTimer(withTimeInterval: 0.13 * Double(index), repeats: false) { (timer) in
                self.titleLabel.text?.append(letter)
            }
        }
    }
    
}

