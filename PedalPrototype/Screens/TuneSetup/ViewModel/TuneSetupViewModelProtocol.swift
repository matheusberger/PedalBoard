//
//  TuneSetupViewModelProtocol.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 27/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

protocol TuneSetupViewModelProtocol {
    
    func getTuneSetup()
    
    func saveTuneSetup(withCompletionBlock: @escaping () -> Void)
}
