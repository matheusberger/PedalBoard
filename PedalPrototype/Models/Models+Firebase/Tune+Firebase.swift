//
//  Tune+Firebase.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 27/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation
import Firebase

extension Tune {
    
    static func from(dataSnapshot: DataSnapshot) -> Tune? {
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
        
        return Tune(withKey: key, withName: name)
    }
}
