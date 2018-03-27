//
//  CreateTuneViewModelProtocol.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 24/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

protocol CreateTuneViewModelProtocol {
    
    weak var pedalSource: PedalSourceProtocol? { get set }
    
    func createTune(withName: String,
                    andPedals: [Pedal],
                    withCompletionBlock: @escaping (Tune) -> Void)
    
    func getPedalsForExhibition() -> [String]
}
