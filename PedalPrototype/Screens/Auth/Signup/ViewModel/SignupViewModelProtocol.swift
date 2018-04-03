//
//  SignupViewModelProtocol.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 02/04/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

protocol SignupViewModelProtocol {
    
    var delegate: SignupViewModelDelegate? { get set }
    
    func signUp(withEmail email: String, password: String, andName name: String)
    
}
