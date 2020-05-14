//
//  RegisterViewController.swift
//  FlashChat
//
//  Created by Claudia Cavalini Maganhi on 13/05/20.
//  Copyright © 2020 Claudia Cavalini Maganhi. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailContainerView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordContainerView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyStyle()
    }
    
    private func applyStyle() {
        emailContainerView.applyShadowRoundCorners()
        passwordContainerView.applyShadowRoundCorners()
    }
    
    @IBAction func register(_ sender: UIButton) {
    }
    

}
