//
//  PedalListViewModelDelegate.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 10/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

protocol PedalListViewModelDelegate: class {
    
    func didUpdatePedalList()
    
    func editPedal()
}
