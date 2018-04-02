//
//  Pedal+Firebase.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 01/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation
import FirebaseDatabase

extension Pedal {
    
    static func from(dataSnapshot: DataSnapshot) -> Pedal? {
        guard dataSnapshot.exists() else {
            return nil
        }
        
        guard let data = dataSnapshot.value as? [String : Any] else {
            return nil
        }
        
        let key: String = dataSnapshot.key
        
        
        guard let name: String = data["name"] as? String else {
            return nil
        }
        
        guard let dataKnobs: [String : Any] = data["knobs"] as? [String : Any] else {
            return nil
        }
        
        var knobs = [String : Int]()
        
        for (knobName, _) in dataKnobs {
            knobs[knobName] = 0
        }
        
        return Pedal(withKey: key, withName: name, andKnobs: knobs)
    }
}
