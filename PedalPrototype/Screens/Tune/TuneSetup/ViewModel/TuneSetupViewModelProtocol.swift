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
    
    func getTuneSetup()
    
    func saveTuneSetup(withCompletionBlock: @escaping () -> Void)
    
    func getPedalCount() -> Int
    
    func getPedalName(atIndex: Int) -> String
    
    func updateSetupForPedal(atIndex: Int, forKnobNamed: String, withValue: Int)
    
    func getKnob(forPedalAtSection: Int, withIndex: Int) -> [String : Int]
    
    func getKnobsCount(forPedalAtIndex: Int) -> Int
    
    func getKnobSetupViewModel(forPedalAtSection: Int, withIndex: Int) -> KnobSetupTVCViewModel
}
