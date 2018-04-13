//
//  PedalTableViewCellViewModelDelegate.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 12/04/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

protocol PedalTableViewCellViewModelDelegate: class {
    
    func setEditingPedal(pedal: Pedal)
}
