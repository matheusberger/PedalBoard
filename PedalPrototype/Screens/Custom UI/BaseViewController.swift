//
//  BaseView.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 04/04/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class BaseView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }

    func dismissKeyboard() {
        view.endEditing(true)
    }
}
