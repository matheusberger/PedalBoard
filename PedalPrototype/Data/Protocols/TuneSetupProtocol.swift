//
//  TuneSetupProtocol.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 31/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

protocol TuneSetupProtocol {
    
    static func getSetup(forTune: Tune, forUser: String, withContinuousFetchBlock: @escaping () -> Void)
    
    static func getSetup(forTune: Tune, forPedal: Pedal, forUser: String, withCompletionBlock: @escaping () -> Void)
    
    static func createSetup(forTune: Tune, forUser: String, withCompletionBlock: @escaping () -> Void)
    
    static func updateSetup(forTune: Tune, forUser: String, withCompletionBlock: @escaping () -> Void)
    
    static func deleteSetup(forTune: Tune, forUser: String, withCompletionBlock: @escaping () -> Void)
}
