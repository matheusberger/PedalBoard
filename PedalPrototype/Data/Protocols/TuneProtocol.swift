//
//  TuneProtocol.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 21/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

protocol TuneProtocol {
    
    static func getTunes(forUser: String, withContinuousFetchBlock: @escaping (_ Tune: Tune) -> Void)
    
    static func create(tune: Tune, forUser: String, withCompletionBlock: @escaping (_ success: Bool) -> Void)
    
    static func delete(tune: Tune, forUser: String, withCompletionBlock: @escaping (_ success: Bool) -> Void)
    
    static func update(tune: Tune, forUser: String, withCompletionBlock: @escaping (_ success: Bool) -> Void)
}
