//
//  KnobProtocol.swift
//  PedalPrototype
//
//  Created by Daniel Barbosa Maranhão on 23/04/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation
import PromiseKit

protocol KnobProtocol {
    
    static func load(withId id: String) -> Promise<Knob>
    
    static func create(withName name: String) -> Promise<Knob>
    
    static func updateName(knob: Knob) -> Promise<Void>
    
    static func delete(knob: Knob) -> Promise<Void>
}
