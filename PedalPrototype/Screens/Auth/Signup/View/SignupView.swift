//
//  SignupView.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 02/04/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class SignupView: BaseViewController {
    
    var viewModel: SignupViewModelProtocol!
    
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent // .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.viewModel = SignupViewModel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signupButton(_ sender: Any) {
        
        guard let name = self.nameTxtField.text else {
            return
        }
        
        guard let email = self.emailTxtField.text else {
            return
        }
        
        guard let password = self.passwordTxtField.text else {
            return
        }
        
        self.viewModel.signUp(withEmail: email, password: password, andName: name)
        self.performSegue(withIdentifier: "signup", sender: nil)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "signup" {
            let loadingView = segue.destination as! LoadingView
            self.viewModel.delegate = loadingView
        }
    }
    
}
