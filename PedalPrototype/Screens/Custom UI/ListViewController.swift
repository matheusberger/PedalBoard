//
//  ListViewController.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 03/12/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var userProfileButton: CircleButton!

    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var titleImageView: UIImageView!
    
    @IBOutlet weak var searchTxtField: PurpleThinTextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = UIView.fromNib()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func beginSearch(_ sender: Any) {
        self.searchTxtField.becomeFirstResponder()
    }
    
    @IBAction func setFilter(_ sender: Any) {}
}

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
