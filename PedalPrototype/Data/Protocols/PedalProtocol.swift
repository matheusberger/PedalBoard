//
//  PedalProtocol.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 01/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

protocol PedalProtocol {

    static func load(withId id: String,
                     withCompletionBlock completionBlock: @escaping (_ pedal: Pedal) -> Void,
                     withFailureBlock failureBlock: @escaping (_ error: PedalRequestError) -> Void)
    
    static func create(withName name: String, andKnobs knobs: [Knob],
                       withCompletionBlock completionBlock: @escaping (_ pedal: Pedal) -> Void,
                       withFailureBlock failureBlock: @escaping (_ error: PedalRequestError) -> Void)
    
    static func delete(pedal: Pedal,
                       withCompletionBlock completionBlock: @escaping () -> Void,
                       withFailureBlock failureBlock: @escaping (_ error: PedalRequestError) -> Void)
    
    static func updateName(pedal: Pedal,
                           withCompletionBlock completionBlock: @escaping () -> Void,
                           withFailureBlock failureBlock: @escaping (_ error: PedalRequestError) -> Void)
    
    static func associate(pedal: Pedal, knob: Knob,
                          withCompletionBlock completionBlock: @escaping () -> Void,
                          withFailureBlock failureBlock: @escaping (_ error: PedalRequestError) -> Void)
    
    static func dissociate(pedal: Pedal, knob: Knob,
                          withCompletionBlock completionBlock: @escaping () -> Void,
                          withFailureBlock failureBlock: @escaping (_ error: PedalRequestError) -> Void)
    
//    static func getPedals(forUser: String,
//                          withContinuousFetchBlock: @escaping (_ pedal: Pedal) -> Void)
//
//    static func getPedal(pedalKey: String,
//                         forUser: String,
//                         withCompletionBlock: @escaping (Pedal?) -> Void)
//
//    static func create(pedal: Pedal,
//                       forUser: String,
//                       withCompletionBlock: @escaping (_ success: Bool) -> Void)
//    static func delete(pedal: Pedal,
//                       forUser user: String,
//                       withCompletionBlock: @escaping (_ success: Bool) -> Void)
//    static func update(pedal: Pedal,
//                       forUser user: String,
//                       withCompletionBlock: @escaping (_ success: Bool) -> Void)
}
