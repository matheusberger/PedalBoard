//
//  EmailAuthProvider.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 18/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation
import FirebaseAuth

class EmailAuthProvider: AuthProtocol {
    
    static func createUser(withEmail email: String, password: String, andName name: String, withCompletionBlock completionBlock: @escaping (PBUser?, Error?) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (user: User?, error: Error?) in
            guard let user = user else {
                print(error!)
                return
            }
            
            completionBlock(PBUser.newFrom(firebaseUser: user, withName: name)!, error)
        }
    }
    
    static func singInUser(withEmail email: String, andPassword password: String, withCompletionBlock completionBlock: @escaping (PBUser?, Error?) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (user: User?, error: Error?) in
            guard let user = user else {
                print(error!)
                return
            }
            
            completionBlock(PBUser.from(firebaseUser: user), error)
        }
    }
    
    
    
    static func signOutUser(withCompletionBlock completionBlock: @escaping (Bool) -> Void) {
        
        var success = true
        
        do {
            try Auth.auth().signOut()
        } catch {
            print("failed to sign out")
            success = false
        }
        
        completionBlock(success)
    }
    
}
