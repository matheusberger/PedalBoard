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
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createTuneButton(_ sender: Any) {
        
        guard let name = self.tuneNameTxtField.text else {
            return
        }
        
        self.viewModel.createTune(withName: name) {
            //perform segue to setup then create setup viewModel with self.viewmodel.pedals (the selected ones)
            let selectedIndexPaths = self.tableView.indexPathsForSelectedRows
            let viewModel = self.viewModel.getTuneSetupViewModel(forIndexPaths: selectedIndexPaths!)
            
            self.performSegue(withIdentifier: "initialTuneSetup", sender: nil)
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

extension CreateTuneView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Parabéns! vc selecionou o pedal \(self.viewModel.getPedalForExhibition(atIndex: indexPath.row))")
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("Awnnn :( vc desselecionou o pedal \(self.viewModel.getPedalForExhibition(atIndex: indexPath.row))")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        }
        
        cell?.textLabel?.text = self.viewModel.getPedalForExhibition(atIndex: indexPath.row)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getPedalCount()
    }
}
