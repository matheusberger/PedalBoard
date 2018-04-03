//
//  KnobSetupTVCViewModel.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 01/04/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

class KnobSetupTVCViewModel: KnobSetupTVCViewModelProtocol {
    
    fileprivate var name: String!
    fileprivate var value: Int!
    
    var completionHandler: (Int) -> Void
    
    init(withName name: String, andValue value: Int, withCompletionHandler completionHandler: @escaping (Int) -> Void) {
        
        self.name = name
        self.value = value
        
        self.completionHandler = completionHandler
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
