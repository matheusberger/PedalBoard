//
//  SignupViewModel.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 02/04/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

class SignupViewModel: SignupViewModelProtocol {
    
    weak var delegate: SignupViewModelDelegate?
    
    func signUp(withEmail email: String, password: String, andName name: String) {
        EmailAuthProvider.createUser(withEmail: email, password: password, andName: name) { (user, error) in
            
            PBUserProvider.update(user: user!, withCompletionBlock: { (error) in
                self.delegate?.didSignUp()
            })
        }
    }
}
