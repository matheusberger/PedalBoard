//
//  PBUserProvider.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 18/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation
import Firebase

class PBUserProvider: PBUserProtocol {
    
    static func getCurrentUser() -> PBUser? {
        return PBUser.from(firebaseUser: Auth.auth().currentUser!)
    }
    
    static func getCurrentUserUID() -> String? {
        
        guard let user = PBUserProvider.getCurrentUser() else {
            return nil
        }
        
        guard let uid = user.uid else {
            return nil
        }
        
        return uid
    }
    
    static func update(user: PBUser, withCompletionBlock completionBlock: @escaping (Error?) -> Void) {
        
        let updateRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        updateRequest?.displayName = user.fullName
        updateRequest?.commitChanges(completion: { (error) in
            completionBlock(error)
        })
    }
}
