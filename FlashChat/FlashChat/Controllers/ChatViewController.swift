//
//  ChatViewController.swift
//  FlashChat
//
//  Created by Claudia Cavalini Maganhi on 13/05/20.
//  Copyright © 2020 Claudia Cavalini Maganhi. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "⚡️FlashChat"

    }
    
    @IBAction func sendMessageTapped(_ sender: UIButton) {
    }
    @IBAction func logOut(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            let navigationController = self.presentingViewController as? UINavigationController
            self.dismiss(animated: true) {
                let _ = navigationController?.popToRootViewController(animated: true)
            }
        } catch let error as NSError {
            //handle error
            print(error.localizedDescription)
        }
        
    }
    
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
    
}
