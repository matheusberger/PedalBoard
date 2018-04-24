//
//  LoginViewViewModel.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 18/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation
import PromiseKit

class LoginViewModel: LoginViewModelProtocol {
    
    weak var delegate: LoginViewModelDelegate?
    
    func signIn(withEmail email: String, andPassword password: String) {
    
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        firstly {
            EmailAuthProvider.singIn(withEmail: email, andPassword: password)
        }.then { userId in
            PBUserProvider.load(withId: userId)
        }.done { user in
            PBUserProvider.setCurrent(user: user)
            self.delegate?.didSignIn()
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
