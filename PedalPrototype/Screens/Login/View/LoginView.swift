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
    
    var authDelegate: FirUIDelegate!
    var vieModel: LoginViewModel!
    
    
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var nameTxtField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.vieModel = LoginViewModel()
        self.vieModel.delegate = self
        self.authDelegate = FirUIDelegate()
        
        let fuiController = self.authDelegate.getAuthViewController()
        
        self.navigationController?.present(fuiController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createAccount(_ sender: Any) {
        self.vieModel.signUp(withEmail: self.emailTxtField.text!, password: self.passwordTxtField.text!, andName: self.nameTxtField.text!)
    }
    
    @IBAction func login(_ sender: Any) {
        self.vieModel.signIn(withEmail: self.emailTxtField.text!, andPassword: self.passwordTxtField.text!)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func didSignIn() {
        print("rolou login")
        print(PBUserProvider.getCurrentUser()!.email)
        print(PBUserProvider.getCurrentUser()!.fullName)
    }
    
    func didSignUp() {
        print("rolou criar conta")
    }
}
