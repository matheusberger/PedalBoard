//
//  PedalProvider.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 01/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation
import FirebaseDatabase

class PedalProvider: PedalProtocol {
    
    static func getPedals(forUser user: String, withContinousFetchBlock continousBlock: @escaping (_ pedal: Pedal) -> Void) {
        
        let databaseReference: DatabaseReference = Database.database().reference()
        
        let pedalsReference: DatabaseReference = databaseReference.child("users").child(user).child("pedals")
        
        pedalsReference.queryOrdered(byChild: "name").observe(.childAdded) { (dataSnapshot) in
            
            if dataSnapshot.exists() {
                if let pedal: Pedal = Pedal.from(dataSnapshot: dataSnapshot) {
                    continousBlock(pedal)
                }
            }
        }
    }
    
    static func getPedals(forUser user: String, forSong song: String, withContinousFetchBlock continousBlock: @escaping (_ pedal: Pedal) -> Void) {
        let databaseReference: DatabaseReference = Database.database().reference()
        
        let pedalsReference: DatabaseReference = databaseReference.child(user).child(song)
        
        pedalsReference.observe(.childAdded) { (dataSnapshot) in
            
            if dataSnapshot.exists() {
                if let pedal: Pedal = Pedal.from(dataSnapshot: dataSnapshot) {
                    continousBlock(pedal)
                }
            }
        }
    }
    
    static func create(pedal: Pedal, forUser user: String, withCompletionBlock completionBlock: @escaping (Bool) -> Void) {
        let databaseReference: DatabaseReference = Database.database().reference()
        
        let pedalReference: DatabaseReference = databaseReference.child("users").child(user).child("pedals").childByAutoId()
        
        pedal.key = pedalReference.key
        pedalReference.setValue(pedal.toDictionary()) { (error, databaseReference) in
            completionBlock(error == nil)
        }
    }
    
    static func delete(pedal: Pedal, forUser user: String, withCompletionBlock completionBlock: @escaping (Bool) -> Void) {
        
        guard let pedalKey = pedal.key else {
            return
        }
        
        let databaseReference: DatabaseReference = Database.database().reference()
        
        let pedalReference: DatabaseReference = databaseReference.child("users").child(user).child("pedals").child(pedalKey)
        
        pedalReference.removeValue() { (error, databaseReference) in
            completionBlock(error == nil)
        }
    }
    
    static func update(pedal: Pedal, forUser user: String, withCompletionBlock completionBlock: @escaping (Bool) -> Void) {
        
        guard let pedalKey = pedal.key else {
            return
        }
        
        let databaseReference: DatabaseReference = Database.database().reference()
        
        let pedalReference: DatabaseReference = databaseReference.child("users").child(user).child("pedals").child(pedalKey)
        
        pedalReference.setValue(pedal.toDictionary()) { (error, databaseReference) in
            completionBlock(error == nil)
        }
    }
}
