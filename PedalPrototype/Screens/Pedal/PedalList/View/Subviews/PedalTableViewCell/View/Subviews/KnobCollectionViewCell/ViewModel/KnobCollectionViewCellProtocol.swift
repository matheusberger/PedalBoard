//
//  KnobCollectionViewCellProtocol.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 27/04/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

protocol KnobCollectionViewCellProtocol {
    
    func getKnobName() -> String
    
    func getPercentage() -> Int
}
