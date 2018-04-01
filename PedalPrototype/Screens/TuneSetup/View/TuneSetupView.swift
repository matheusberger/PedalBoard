//
//  TuneSetupView.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 29/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class TuneSetupView: UIViewController {
    
    var viewModel: TuneSetupViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("vamo pegar as config")
        self.viewModel.getTuneSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveButton(_ sender: Any) {
        self.viewModel.saveTuneSetup {
            self.navigationController?.popToRootViewController(animated: true)
        }
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
