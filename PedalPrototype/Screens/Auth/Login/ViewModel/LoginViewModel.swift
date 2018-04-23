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
        
        EmailAuthProvider.singIn(withEmail: email, andPassword: password, withCompletionBlock: { (userId) in
            
            PBUserProvider.load(withId: userId, withCompletionBlock: { (user) in
                
                PBUserProvider.setCurrent(user: user)
                
                
            }, withFailureBlock: { (UserRequestError) in
                //TODO: handle errors
            })
            
        }, withFailureBlock: { (AuthRequestError) in
            //TODO: handle errors
        })
    }
}
