//
//  TuneProvider.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 27/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation
import Firebase

class TuneProvider: TuneProtocol {
    
    static func getTunes(forUser user: String, withContinuousFetchBlock continuousBlock: @escaping (Tune) -> Void) {
        let databaseReference: DatabaseReference = Database.database().reference()
        
        let tunesReference: DatabaseReference = databaseReference.child("tunes").child(user)
        
        tunesReference.queryOrdered(byChild: "name").observe(.childAdded) { (dataSnapshot) in
            
            if dataSnapshot.exists() {
                if let tune: Tune = Tune.from(dataSnapshot: dataSnapshot) {
                    continuousBlock(tune)
                }
            }
        }
    }
    
    static func create(Tune: Tune, forUser: String, withCompletionBlock: @escaping (Bool) -> Void) {
        
    }
    
    static func delete(Tune: Tune, forUser: String, withCompletionBlock: @escaping (Bool) -> Void) {
        
    }
    
    static func update(Tune: Tune, forUser: String, withCompletionBlock: @escaping (Bool) -> Void) {
        
    }
}
