//
//  PedalProtocol.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 01/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

protocol PedalProtocol {
    
    static func getPedals(forUser: String,
                          withContinousFetchBlock: @escaping (_ pedal: Pedal) -> Void)
    
    static func getPedals(forUser: String, forSong: String,
                          withContinousFetchBlock: @escaping (_ pedal: Pedal) -> Void)
    
    static func create(pedal: Pedal,
                       forUser: String,
                       withCompletionBlock: @escaping (_ success: Bool) -> Void)
    static func delete(pedal: Pedal,
                       forUser user: String,
                       withCompletionBlock: @escaping (_ success: Bool) -> Void)
    static func update(pedal: Pedal,
                       forUser user: String,
                       withCompletionBlock: @escaping (_ success: Bool) -> Void)
}
