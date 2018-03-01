//
//  PedalProvider.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 01/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation
import Firebase

class PedalProvider: PedalProtocol {
    
    static func getPedals(forUser: String, withContinousFetchBlock completionBlock: @escaping ([Pedal]) -> Void) {
        
    }
    
    static func getPedals(forSong: String, withContinousFetchBlock completionBlock: @escaping ([Pedal]) -> Void) {
        
    }
    
    static func create(pedal: Pedal, withCompletionBlock completionBlock: @escaping (Bool) -> Void) {
        
    }
    
    static func delete(pedal: Pedal, withCompletionBlock completionBlock: @escaping (Bool) -> Void) {
        
    }
    
    static func update(pedal: Pedal, withCompletionBlock completionBlock: @escaping (Bool) -> Void) {
        
    }
    
    
    
}
