//
//  KnobSetupTVCViewModel.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 01/04/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

class KnobSetupTVCViewModel: KnobSetupTVCViewModelProtocol {
    
    var name: String!
    var value: Int!
    
    init(withName name: String, andValue value: Int) {
        self.name = name
        self.value = value
    }
    
    func getKnobName() -> String {
        return self.name
    }
    
    func getKnobValue() -> Int {
        return self.value
    }
    
    func setKnobValue(value: Int) {
        self.value = value
    }
}
