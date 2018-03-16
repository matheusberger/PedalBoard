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

class LoginViewController: UIViewController {
    
    var authDelegate: FirUIDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.authDelegate = FirUIDelegate()
        
        let fuiController = self.authDelegate.getAuthViewController()
        
        self.navigationController?.present(fuiController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
