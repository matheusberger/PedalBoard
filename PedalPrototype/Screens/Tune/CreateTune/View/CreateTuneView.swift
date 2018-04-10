//
//  CreateTuneView.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 28/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class CreateTuneView: UIViewController {

    var viewModel: CreateTuneViewModelProtocol!
    
    
    @IBOutlet weak var tuneNameTxtField: UITextField!
    @IBOutlet weak var artistNameTxtField: PurpleTextField!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent // .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let rootTabBarController = self.tabBarController as! RootTabController
        rootTabBarController.toogleTabBar(on: false)
    }

    @IBAction func cancelButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func createTuneButton(_ sender: Any) {
        
        guard let name = self.tuneNameTxtField.text else {
            return
        }
        
        guard let artist = self.artistNameTxtField.text else {
            return
        }
        
        self.viewModel.createTune(withName: name, andArtist: artist) {
            
//            self.performSegue(withIdentifier: "initialTuneSetup", sender: nil)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
