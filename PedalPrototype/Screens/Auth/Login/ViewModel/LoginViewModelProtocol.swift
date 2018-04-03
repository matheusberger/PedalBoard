//
//  LoginViewModelProtocol.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 18/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

protocol LoginViewModelProtocol {
    
    var delegate: LoginViewModelDelegate? { get set }
    
    func signIn(withEmail email: String, andPassword password: String)
}
