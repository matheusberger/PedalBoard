//
//  ConfigurePedalViewDelegate.swift
//  PedalPrototype
//
//  Created by Daniel Barbosa Maranhão on 03/05/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

protocol ConfigurePedalViewDelegate: class {
    
    func didCreate(pedal: Pedal)
    
    func didEdit(pedal: Pedal)
    
}
