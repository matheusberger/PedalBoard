//
//  TuneSetupViewModelDelegate.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 01/04/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

protocol TuneSetupViewModelDelegate: class {
    
    func didUpdatePedalList()
    
    func didUpdateSetup()
}
