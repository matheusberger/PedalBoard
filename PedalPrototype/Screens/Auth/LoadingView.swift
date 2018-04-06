//
//  LoadingView.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 04/04/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class LoadingView: UIViewController, LoginViewModelDelegate, SignupViewModelDelegate {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent // .default
    }
    
    func didSignIn() {
        self.performSegue(withIdentifier: "success", sender: nil)
    }
    
    func faliedToLogin() {
        
    }
    
    func didSignUp() {
        self.performSegue(withIdentifier: "success", sender: nil)
    }
    
    func faliedToSignup() {
        
    }
}
