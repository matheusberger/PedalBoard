//
//  StatusBarNavigationController.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 02/04/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class StatusBarNavigationController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.topViewController!.preferredStatusBarStyle
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
