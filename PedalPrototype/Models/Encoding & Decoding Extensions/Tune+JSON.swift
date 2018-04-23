//
//  Tune+Firebase.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 27/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation
import SwiftyJSON

extension Tune {
    
    static func from(data: JSON) -> Tune? {
        
        guard let id = data["_id"].string else {
            return nil
        }
        
        guard let name = data["name"].string else {
            return nil
        }
        
        guard let artist = data["artist"].string else {
            return nil
        }
        
        var pedalSetups: [PedalSetup] = []
        if let pedalSetupsData = data["pedalSetups"].array {
            pedalSetups = pedalSetupsData.compactMap{ PedalSetup.from(data: $0) }
        }
        
        return Tune(withId: id, withName: name, withArtist: artist, andPedalSetups: pedalSetups)
    }
}
