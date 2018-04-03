//
//  PedalSourceProtocol.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 24/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

protocol PedalSourceProtocol: class {
    
    func getPedalList() -> [Pedal]
}
