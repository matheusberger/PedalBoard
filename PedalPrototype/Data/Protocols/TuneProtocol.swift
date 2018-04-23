//
//  TuneProtocol.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 21/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

protocol TuneProtocol {
    
    static func load(withId id: String,
                    withCompletionBlock completionBlock: @escaping (_ Tune: Tune) -> Void,
                    withFailureBlock failureBlock: @escaping (_ error: TuneRequestError) -> Void) //ok
    
    static func create(withName name: String, andArtist artist: String,
                       withCompletionBlock completionBlock: @escaping (_ tune: Tune) -> Void,
                       withFailureBlock failureBlock: @escaping (_ error: TuneRequestError) -> Void)
    
    static func updateName(tune: Tune,
                           withCompletionBlock completionBlock: @escaping () -> Void,
                           withFailureBlock failureBlock: @escaping (_ error: TuneRequestError) -> Void)
    
    static func updateArtist(tune: Tune,
                             withCompletionBlock completionBlock: @escaping () -> Void,
                             withFailureBlock failureBlock: @escaping (_ error: TuneRequestError) -> Void)
    
    static func delete(tune: Tune,
                       withCompletionBlock completionBlock: @escaping () -> Void,
                       withFailureBlock failureBlock: @escaping (_ error: TuneRequestError) -> Void)
    
    static func associate(tune: Tune, pedal: Pedal,
                          withCompletionBlock completionBlock: @escaping () -> Void,
                          withFailureBlock failureBlock: @escaping (_ error: TuneRequestError) -> Void)
    
    static func dissociate(tune: Tune, pedal: Pedal,
                           withCompletionBlock completionBlock: @escaping () -> Void,
                           withFailureBlock failureBlock: @escaping (_ error: TuneRequestError) -> Void)
    
    static func updateValue(tune: Tune, pedal: Pedal, knob: Knob,
                            withCompletionBlock completionBlock: @escaping () -> Void,
                            withFailureBlock failureBlock: @escaping (_ error: TuneRequestError) -> Void)
}
