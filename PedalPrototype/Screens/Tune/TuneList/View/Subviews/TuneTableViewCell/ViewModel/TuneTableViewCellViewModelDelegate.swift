//
//  TuneTableViewCellViewModelDelegate.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 04/04/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

protocol TuneTableViewCellViewModelDelegate: class {
    
    func didSelectSetup(atIndex: Int)
}
