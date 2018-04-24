//
//  SignupViewModel.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 02/04/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation
import PromiseKit

class SignupViewModel: SignupViewModelProtocol {
    
    weak var delegate: SignupViewModelDelegate?
    
    func signUp(withEmail email: String, password: String, andName name: String) {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        firstly {
            PBUserProvider.create(withEmail: email, withPassword: password, andName: name)
        }.then {
            EmailAuthProvider.singIn(withEmail: email, andPassword: password)
        }.then { userId in
            PBUserProvider.load(withId: userId)
        }.done { user in
            PBUserProvider.setCurrent(user: user)
            self.delegate?.didSignUp()
        }.ensure {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }.catch { error in
            
            let error = error as NSError
            if let requestEndpoint = RequestEndpoint(rawValue: error.domain) {
                let requestError = RequestError.from(endpoint: requestEndpoint, withHttpErrorCode: error.code)
                //TODO: handle requestError!
                //self.delegate?.faliedToLogin()
            }
        }
    }
}
