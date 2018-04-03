//
//  KnobSetupTVCViewModelProtocol.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 01/04/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

protocol KnobSetupTVCViewModelProtocol {
    
    var completionHandler: (Int) -> Void { get set }
    
    func getKnobName() -> String
    
    func getKnobValue() -> Int
    
    func setKnobValue(value: Int)
}
