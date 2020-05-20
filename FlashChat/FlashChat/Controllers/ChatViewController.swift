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
    
    let db = Firestore.firestore()
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMessages()
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellID)
    }
    
    @IBAction func sendMessageTapped(_ sender: UIButton) {
        guard let message = messageTextField.text else { return }
        if !message.isEmpty {
            if let messageBody = messageTextField.text, let sender = Auth.auth().currentUser?.email {
                db.collection(Constants.Firestore.collectionName).addDocument(data: [Constants.Firestore.senderField: sender, Constants.Firestore.bodyField: messageBody, Constants.Firestore.dateField: Date().timeIntervalSince1970]) { (error) in
                    
                    self.messageTextField.text = ""
                    if let error = error {
                        //handle error
                        print(error)
                        
                    }
                }
            }
        }
    }
    
    private func loadMessages() {
        db.collection(Constants.Firestore.collectionName)
            .order(by: Constants.Firestore.dateField)
            .addSnapshotListener { (querySnapshot, error) in
            self.messages = []
            if let err = error {
                //handle error
                print(err)
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let sender = data[Constants.Firestore.senderField] as? String, let messageBody = data[Constants.Firestore.bodyField] as? String {
                            let newMessage = Message(sender: sender, body: messageBody)
                            self.messages.append(newMessage)
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
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
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellID, for: indexPath) as! MessageCell
        cell.selectionStyle = .none
        cell.messageLabel.text = messages[indexPath.row].body
        return cell
        
    }
    
    
}
