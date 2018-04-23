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
        
        PBUserProvider.create(withEmail: email, password: password, andName: name, withCompletionBlock: {
        
            EmailAuthProvider.singIn(withEmail: email, andPassword: password, withCompletionBlock: { (userId) in
                
                PBUserProvider.load(withId: userId, withCompletionBlock: { (user) in
                    
                    PBUserProvider.setCurrent(user: user)
                    
                    self.delegate?.didSignUp()
                    
                }, withFailureBlock: { (userLoadRequestError) in
                    //TODO: handle errors
                })
                
            }, withFailureBlock: { (authRequestError) in
                //TODO: handle errors
            })
            
        }, withFailureBlock: { (userCreateRequestError) in
            //TODO: handle errors
        })
    }
}
