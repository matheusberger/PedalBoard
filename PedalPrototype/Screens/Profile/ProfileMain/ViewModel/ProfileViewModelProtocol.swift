//
//  ProfileViewModelProtocol.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 10/04/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

protocol ProfileViewModelProtocol {
    
    func getUserName() -> String
    
    func getUserEmail() -> String
    
    func getNumberOfPedals() -> Int
}
