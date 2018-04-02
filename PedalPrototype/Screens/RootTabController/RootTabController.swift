//
//  RootTabController.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 28/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class RootTabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var views: [UIViewController] = []
        
        // Do any additional setup after loading the view.
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
