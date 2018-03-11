//
//  CreatePedalViewModelProtoco.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 04/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

protocol CreatePedalViewModelProtocol {
    
    func createPedal(withName: String,
                     andKnobs: [String],
                     withCompletionBlock completionBlock: @escaping () -> Void)
}
