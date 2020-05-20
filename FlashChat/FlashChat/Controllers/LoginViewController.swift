//
//  LoginViewController.swift
//  FlashChat
//
//  Created by Claudia Cavalini Maganhi on 13/05/20.
//  Copyright © 2020 Claudia Cavalini Maganhi. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
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
    
    @IBAction func login(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            //handle error
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (authResult, error) in
            if let error = error {
                //handle error
                print(error.localizedDescription)
            } else {
                guard let chatViewController = self?.storyboard?.instantiateViewController(withIdentifier: Constants.chatStoryboardID) as? ChatViewController else { return }
                self?.navigationController?.pushViewController(chatViewController, animated: true)
            }
        }
    }
    
}
