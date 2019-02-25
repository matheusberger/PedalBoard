//
//  TuneSetupViewModelProtocol.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 27/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

protocol TuneSetupViewModelProtocol {
    
    var delegate: TuneSetupViewModelDelegate? { get set }
    
    func getNumberOfPedals() -> Int
    
    func getTVCHeightForPedal(atIndex: IndexPath) -> Int
    
    func getTuneSetupCVCViewModelForPedal(atIndex: IndexPath) -> TuneSetupCVCViewModelProtocol
}
