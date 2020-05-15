//
//  RegisterViewController.swift
//  FlashChat
//
//  Created by Claudia Cavalini Maganhi on 13/05/20.
//  Copyright © 2020 Claudia Cavalini Maganhi. All rights reserved.
//

import UIKit
import Firebase

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
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            //handle error
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                //handle error
                print(error.localizedDescription)
            } else {
                guard let chatViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController else { return }
                chatViewController.modalPresentationStyle = .fullScreen
                
                self.present(chatViewController, animated: true, completion: nil)
            }
        }
    }
   

}
