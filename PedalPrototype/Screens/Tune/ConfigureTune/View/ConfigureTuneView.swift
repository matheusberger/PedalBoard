//
//  ConfigureTuneView.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 28/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class ConfigureTuneView: UIViewController {

    var viewModel: ConfigureTuneViewModelProtocol!
    
    
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
        
        self.tuneNameTxtField.text = self.viewModel.getTuneName()
        self.artistNameTxtField.text = self.viewModel.getArtistName()
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
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tuneSetupSegue" {
            let viewModel = self.viewModel.getTuneSetupViewModel()
            let view = segue.destination as! TuneSetupView
            view.viewModel = viewModel
        }
    }

}
