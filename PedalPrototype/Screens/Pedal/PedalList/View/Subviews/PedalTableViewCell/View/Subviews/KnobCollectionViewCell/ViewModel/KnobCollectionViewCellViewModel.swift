//
//  KnobCollectionViewCellViewModel.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 27/04/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

class KnobCollectionViewCellViewModel: KnobCollectionViewCellProtocol {
    
    var name: String
    var value: Int
    
    init(withName name: String, andPercentage value: Int) {
        self.name = name
        self.value = value
    }
    
    func getKnobName() -> String {
        return self.name
    }
    
    func getPercentage() -> Int {
        return self.value
    }
}
