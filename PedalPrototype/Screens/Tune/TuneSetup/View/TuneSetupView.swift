//
//  TuneSetupView.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 29/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class TuneSetupView: BaseViewController {
    
    var viewModel: TuneSetupViewModelProtocol!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel.delegate = self
        self.viewModel.getTuneSetup()
        self.tableView.delegate = self
        self.tableView.dataSource = self
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
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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

extension TuneSetupView: TuneSetupViewModelDelegate {
    
    func didUpdateSetup() {
        self.tableView.reloadData()
    }
    
    func didUpdatePedalList() {
        self.tableView.reloadData()
    }
}

extension TuneSetupView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return self.viewModel.getPedalName(atIndex: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "setupCell") as! KnobSetupTVCView
        
        if cell.viewModel == nil {
            cell.viewModel = self.viewModel.getKnobSetupViewModel(forPedalAtSection: indexPath.section, withIndex: indexPath.row)
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.getPedalCount()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getKnobsCount(forPedalAtIndex: section)
    }
}
