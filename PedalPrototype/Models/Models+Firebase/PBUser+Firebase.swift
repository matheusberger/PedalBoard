//
//  User+Firebase.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 18/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

extension PBUser {

    static func from(firebaseUser: User) -> PBUser? {
        
        let uid = firebaseUser.uid
        
        guard let name = firebaseUser.displayName else {
            return nil
        }
        
        guard let email = firebaseUser.email else {
            return nil
        }
        
        var full = name.components(separatedBy: " ")
        let first = full[0]
        full.remove(at: 0)
        
        var last: String = String()
        for surname in full {
            last = last + " " + surname
        }
        
        return PBUser(withUID: uid, withEmail: email, withFirstName: first, andSurname: last)
    }
    
    static func newFrom(firebaseUser: User, withName name: String) -> PBUser? {
        let uid = firebaseUser.uid
        
        guard let email = firebaseUser.email else {
            return nil
        }
        
        var full = name.components(separatedBy: " ")
        let first = full[0]
        full.remove(at: 0)
        
        var last: String = String()
        for surname in full {
            last = last + " " + surname
        }
        
        return PBUser(withUID: uid, withEmail: email, withFirstName: first, andSurname: last)
    }
}
