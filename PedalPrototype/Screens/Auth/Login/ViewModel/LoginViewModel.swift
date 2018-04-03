//
//  LoginViewViewModel.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 18/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

class LoginViewModel: LoginViewModelProtocol {
    
    var delegate: LoginViewModelDelegate?
    
    func signIn(withEmail email: String, andPassword password: String) {
        EmailAuthProvider.singInUser(withEmail: email, andPassword: password) { (user: PBUser?, error: Error?) in
            self.delegate?.didSignIn()
        }
    }
}
