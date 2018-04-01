//
//  TuneSetupProvider.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 31/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation
import Firebase

class TuneSetupProvider: TuneSetupProtocol {
    
    static func getSetup(forTune tune: Tune, forUser userUID: String, withContinuousFetchBlock continuousFetchBlock: @escaping () -> Void) {
        
        guard let tuneKey = tune.key else {
            return
        }
        
        
        let databaseReference = Database.database().reference()
        let tuneSetupReference = databaseReference.child("setups").child(tuneKey).child(userUID)
        
        tuneSetupReference.observe(.childAdded) { (dataSnapshot) in
            PedalProvider.getPedal(pedalKey: dataSnapshot.key, forUser: userUID, withCompletionBlock: { (pedal) in
                
                tune.tuneSetup?.setup(pedal: pedal, fromDataSnapshot: dataSnapshot)
                continuousFetchBlock()
            })
        }
    }
    
    static func createSetup(forTune: Tune, forUser: String, withCompletionBlock: @escaping () -> Void) {
        
    }
    
    static func updateSetup(forTune: Tune, forUser: String, withCompletionBlock: @escaping () -> Void) {
        
    }
    
    static func daleteSetup(forTune: Tune, forUser: String, withCompletionBlock: @escaping () -> Void) {
        
    }
    
    
}
