//
//  PedalProtocol.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 01/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation
import PromiseKit

protocol PedalProtocol {

    static func load(withId id: String) -> Promise<Pedal>
    
    static func create(withName name: String, andKnobs knobs: [Knob]) -> Promise<Pedal>
    
    static func updateName(pedal: Pedal) -> Promise<Void>
    
    static func associate(knob: Knob, withPedal pedal: Pedal) -> Promise<Void>
    
    static func dissociate(knob: Knob, withPedal pedal: Pedal) -> Promise<Void>
    
}
