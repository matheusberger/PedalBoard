//
//  CreatePedalViewModelProtoco.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 04/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

protocol ConfigurePedalViewModelProtocol {
    
    func configurePedal(withName: String,
                     andKnobs: [String],
                     withCompletionBlock completionBlock: @escaping (_ pedal: Pedal) -> Void)
    
    func getPedalName() -> String
    
    func isEditingPedal() -> Bool
    
    func getKnobs(withContinuousBlock: @escaping (String) -> Void)
}
