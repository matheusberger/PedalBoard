//
//  ProfileView.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 07/04/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class ProfileView: BaseViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var numRegisteredPedals: UILabel!
    @IBOutlet weak var logoutButtonOutlet: PurpleShadowButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    fileprivate var viewModel: ProfileViewModelProtocol! {
        didSet {
            self.userNameLabel.text = viewModel.getUserName()
            self.emailLabel.text = viewModel.getUserEmail()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = ProfileViewModel()
        
        self.emailLabel.textColor = UIColor.silverSand
        self.numRegisteredPedals.textColor = UIColor.silverSand
        self.logoutButtonOutlet.backgroundColor = UIColor.watermelon
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let rootTabController = self.tabBarController as! RootTabController
        rootTabController.toogleTabBar(on: false)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "pedalListSegue" {
            let pedalList = segue.destination as! PedalListView
            pedalList.viewModel = self.viewModel.getPedalListViewModel()
        }
    }

}
