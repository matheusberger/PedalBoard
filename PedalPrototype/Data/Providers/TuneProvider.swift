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
//        let databaseReference: DatabaseReference = Database.database().reference()
//
//        let tunesReference: DatabaseReference = databaseReference.child("tunes").child(user)
//
//        tunesReference.queryOrdered(byChild: "name").observe(.childAdded) { (dataSnapshot) in
//
//            if dataSnapshot.exists() {
//                if let tune: Tune = Tune.from(dataSnapshot: dataSnapshot) {
//                    continuousBlock(tune)
//                }
//            }
//        }
    }
    
    static func create(tune: Tune, forUser user: String, withCompletionBlock completionBlock: @escaping (Bool) -> Void) {
//        let databaseReference: DatabaseReference = Database.database().reference()
//
//        let tunesReference = databaseReference.child("tunes").child(user).childByAutoId()
//
//        tune.key = tunesReference.key
//        tunesReference.setValue(tune.toDictionary()) { (error, databaseReferences) in
//            completionBlock(error == nil)
//        }
    }
    
    static func delete(tune: Tune, forUser user: String, withCompletionBlock completionBlock: @escaping (Bool) -> Void) {
//
//        guard let tuneKey = tune.key else {
//            return
//        }
//
//        let databaseReference: DatabaseReference = Database.database().reference()
//
//        let tunesReference = databaseReference.child("tunes").child(user).child(tuneKey)
//        tunesReference.removeValue { (error, databaseReference) in
//            completionBlock(error == nil)
//        }
    }
    
    static func update(tune: Tune, forUser user: String, withCompletionBlock completionBlock: @escaping (Bool) -> Void) {
//        
//        guard let tuneKey = tune.key else {
//            return
//        }
//        
//        let databaseReference: DatabaseReference = Database.database().reference()
//        
//        let tunesReference = databaseReference.child("tunes").child(user).child(tuneKey)
//        tunesReference.setValue(tune.toDictionary()) { (error, databaseReference) in
//            completionBlock(error == nil)
//        }
    }
}
