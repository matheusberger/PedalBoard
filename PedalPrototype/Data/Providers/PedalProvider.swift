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
    
    static func getPedals(forUser user: String, withContinuousFetchBlock continuousBlock: @escaping (_ pedal: Pedal) -> Void) {
        
        let databaseReference: DatabaseReference = Database.database().reference()
        
        let pedalsReference: DatabaseReference = databaseReference.child("pedals").child(user)
        
        pedalsReference.queryOrdered(byChild: "name").observe(.childAdded) { (dataSnapshot) in
            
            if dataSnapshot.exists() {
                if let pedal: Pedal = Pedal.from(dataSnapshot: dataSnapshot) {
                    continuousBlock(pedal)
                }
            }
        }
    }
    
    static func getPedal(pedalKey: String, forUser user: String, withCompletionBlock completionBlock: @escaping (Pedal?) -> Void) {
        let databaseReference: DatabaseReference = Database.database().reference()
        
        let pedalsReference: DatabaseReference = databaseReference.child("pedals").child(user).child(pedalKey)
        
        pedalsReference.observeSingleEvent(of: .value) { (dataSnapshot) in
            completionBlock(Pedal.from(dataSnapshot: dataSnapshot))
        }
    }
    
    static func create(pedal: Pedal, forUser user: String, withCompletionBlock completionBlock: @escaping (Bool) -> Void) {
        let databaseReference: DatabaseReference = Database.database().reference()
        
        let pedalReference: DatabaseReference = databaseReference.child("pedals").child(user).childByAutoId()
        
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
        
        let pedalReference: DatabaseReference = databaseReference.child("pedals").child(user).child(pedalKey)
        
        pedalReference.removeValue() { (error, databaseReference) in
            completionBlock(error == nil)
        }
    }
    
    static func update(pedal: Pedal, forUser user: String, withCompletionBlock completionBlock: @escaping (Bool) -> Void) {
        
        guard let pedalKey = pedal.key else {
            return
        }
        
        let databaseReference: DatabaseReference = Database.database().reference()
        
        let pedalReference: DatabaseReference = databaseReference.child("pedals").child(user).child(pedalKey)
        
        pedalReference.setValue(pedal.toDictionary()) { (error, databaseReference) in
            completionBlock(error == nil)
        }
    }
}
