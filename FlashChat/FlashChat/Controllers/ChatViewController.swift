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
        navigationItem.setHidesBackButton(true, animated: true)
        setLogoutButton()
        title = Constants.appName
    }
    
    @IBAction func sendMessageTapped(_ sender: UIButton) {
        guard let message = messageTextField.text else { return }
        if !message.isEmpty {
            if let messageBody = messageTextField.text, let sender = Auth.auth().currentUser?.email {
                db.collection(Constants.Firestore.collectionName).addDocument(data: [Constants.Firestore.senderField: sender, Constants.Firestore.bodyField: messageBody, Constants.Firestore.dateField: Date().timeIntervalSince1970]) { (error) in
                    if let error = error {
                        //handle error
                        print(error)
                    } else {
                        DispatchQueue.main.async {
                            self.messageTextField.text = ""
                        }
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
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func setLogoutButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logOut))
    }
    
    @objc func logOut() {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
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
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellID, for: indexPath) as! MessageCell
        cell.selectionStyle = .none
        cell.messageLabel.text = message.body
        if message.sender == Auth.auth().currentUser?.email {
            cell.rightImageView.isHidden = false
            cell.leftImageView.isHidden = true
            cell.messageContainerView.backgroundColor = #colorLiteral(red: 0.48765558, green: 0.6202688813, blue: 0.7409835458, alpha: 0.5)
            cell.messageLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        } else {
            cell.rightImageView.isHidden = true
            cell.leftImageView.isHidden = false
            cell.messageContainerView.backgroundColor = #colorLiteral(red: 0.5054885149, green: 0.6637036204, blue: 0.6215990186, alpha: 0.5032472201)
            cell.messageLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        
        return cell
        
    }
    
    
}
