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

    internal var user: PBUser!
    
    static var shared: PBUserProvider!
    
    init() {
        PBUserProvider.observeCurrentUser()
    }
    
    static func observeCurrentUser() {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                PBUserProvider.shared.user = PBUser.from(firebaseUser: user)
                PBUserProvider.getUserImage()
            }
        }
    }
    
    static func userDataIsAvailable(completionBlock: @escaping () -> Void) {
        while PBUserProvider.shared.user == nil {}
        
        completionBlock()
    }
    
    static func getCurrentUser() -> PBUser {
        return PBUserProvider.shared.user    
    }
    
    static func getUserImage() {
        let storage = Storage.storage()
        let ref = storage.reference(withPath: "/profile_images/\(PBUserProvider.getCurrentUser().uid!)img")
        
        ref.getData(maxSize: 2 * 1024 * 1024) { (data, error) in
            if error == nil {
                PBUserProvider.getCurrentUser().picture = data
            }
            else {
                print(error!.localizedDescription)
            }
        }
    }
    
    static func update(user: PBUser, withCompletionBlock completionBlock: @escaping (Error?) -> Void) {
        
        let updateRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        updateRequest?.displayName = user.fullName
        updateRequest?.commitChanges(completion: { (error) in
            
            let storage = Storage.storage()
            let ref = storage.reference()
            
            let imgRef = ref.child("/profile_images/\(user.uid!)img")
            
            if let img = user.picture {
                imgRef.putData(img)
            }
            
            completionBlock(error)
        })
    }
}
