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
                          withContinousFetchBlock completionBlock: @escaping (_ pedals: [Pedal]) -> Void)
    
    static func getPedals(forSong: String,
                          withContinousFetchBlock completionBlock: @escaping (_ pedals: [Pedal]) -> Void)
    
    static func create(pedal: Pedal,
                       withCompletionBlock completionBlock: @escaping (_ success: Bool) -> Void)
    static func delete(pedal: Pedal,
                       withCompletionBlock completionBlock: @escaping (_ success: Bool) -> Void)
    static func update(pedal: Pedal,
                       withCompletionBlock completionBlock: @escaping (_ success: Bool) -> Void)
}
