//
//  RootTabController.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 28/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class RootTabController: UITabBarController {

    @IBOutlet var customTabBar: UIView!
    @IBOutlet weak var discoverButton: UIButton!
    @IBOutlet weak var tunesButton: UIButton!
    @IBOutlet weak var setlistButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTabBar()
        
        var views: [UIViewController] = []
        
        for vc in self.viewControllers! {
            let nc = vc as! UINavigationController

            views.append(nc.viewControllers[0])
        }

        let pedalListView = views[0] as! PedalListView
        let tuneListView = views[1] as! TuneListView

        let pedalViewModel = PedalListViewModel()
        let tuneViewModel = TuneListViewModel()

        tuneViewModel.dataSource = pedalViewModel

        tuneListView.setViewModel(viewModel: tuneViewModel)
        pedalListView.setViewModel(viewModel: pedalViewModel)
    }
    
    func setupTabBar() {
        let width = self.view.frame.size.width
        self.customTabBar.frame.size.height = 49
        
        self.customTabBar.frame = CGRect(x: 0, y: self.view.frame.size.height-49, width: width, height: 49)
        
        self.customTabBar.layer.borderColor = UIColor.silverSand.cgColor
        self.customTabBar.layer.borderWidth = 0.3
        
        self.customTabBar.layer.shadowRadius = 5
        self.customTabBar.layer.shadowColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        self.customTabBar.layer.shadowOpacity = 1
        
        self.view.addSubview(self.customTabBar)
        self.tabBar.isHidden = true
        
        self.selectedIndex = 1
        self.tunesButton.isSelected = true
        
        self.setupButtons(withWidth: width/3)
    }
    
    func setupButtons(withWidth width: CGFloat) {
        self.discoverButton.setTitle("DISCOVER", for: .normal)
        self.discoverButton.setTitleColor(UIColor.silverSand, for: .normal)
        self.discoverButton.setTitleColor(UIColor.hanPurple, for: .selected)
        self.discoverButton.frame = CGRect(x: 0, y: 0, width: width, height: 49)
        
        self.tunesButton.setTitle("TUNES", for: .normal)
        self.tunesButton.setTitleColor(UIColor.silverSand, for: .normal)
        self.tunesButton.setTitleColor(UIColor.hanPurple, for: .selected)
        self.tunesButton.frame = CGRect(x: width, y: 0, width: width, height: 49)
        
        self.setlistButton.setTitle("SETLIST", for: .normal)
        self.setlistButton.setTitleColor(UIColor.silverSand, for: .normal)
        self.setlistButton.setTitleColor(UIColor.hanPurple, for: .selected)
        self.setlistButton.frame = CGRect(x: 2*width, y: 0, width: width, height: 49)
    }

    @IBAction func selectIndex(_ sender: UIButton) {
        
        switch self.selectedIndex {
        case 0:
            self.discoverButton.isSelected = false
            break
        case 1:
            self.tunesButton.isSelected = false
            break
        case 2:
            self.setlistButton.isSelected = false
            break
        default:
            break
        }
        
        self.selectedIndex = sender.tag
        sender.isSelected = true
    }
}
