//
//  LoginViewController.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 16/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuthUI

class LoginView: UIViewController, LoginViewModelDelegate {
    
    var vieModel: LoginViewModel!
    
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent // .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.vieModel = LoginViewModel()
        self.vieModel.delegate = self
        self.navigationController?.navigationBar.isHidden = true
        self.setNeedsStatusBarAppearanceUpdate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(_ sender: Any) {
        
        guard let email = self.emailTxtField.text else {
            return
        }
        
        guard let password = self.passwordTxtField.text else {
            return
        }
        
        self.vieModel.signIn(withEmail: email, andPassword: password)
    }

    func didSignIn() {
        print(PBUserProvider.getCurrentUser()!.fullName)
        self.performSegue(withIdentifier: "login", sender: nil)
    }
}
