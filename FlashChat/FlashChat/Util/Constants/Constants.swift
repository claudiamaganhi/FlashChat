//
//  Constants.swift
//  FlashChat
//
//  Created by Claudia Cavalini Maganhi on 15/05/20.
//  Copyright © 2020 Claudia Cavalini Maganhi. All rights reserved.
//

import Foundation

struct Constants {
    static let appName = "⚡️FlashChat"
    static let registerStoryboardID = "RegisterViewController"
    static let loginStoryboardID = "LoginViewController"
    static let chatStoryboardID = "ChatViewController"
    static let cellID = "cellId"
    static let cellNibName = "MessageCell"
    
    struct Firestore {
        static let collectionName = "messages"
        static let senderField = "senderField"
        static let bodyField = "bodyField"
        static let dateField = "dateField"
    }
}
