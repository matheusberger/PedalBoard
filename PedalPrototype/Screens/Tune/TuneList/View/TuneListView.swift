//
//  TuneListView.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 28/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class TuneListView: BaseViewController, TuneListViewModelDelegate, TuneTableViewCellViewModelDelegate {

    fileprivate var viewModel: TuneListViewModel! //initialized by RootTabController
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTxtField: PurpleTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.viewModel.delegate = self
        self.viewModel.getTunes()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setViewModel(viewModel: TuneListViewModel) {
        self.viewModel = viewModel
    }
    
    func didUpdateTuneList() {
        self.tableView.reloadData()
    }
    
    func didSelectSetup(atIndex index: Int) {
        self.viewModel.selectedTune = index
        self.performSegue(withIdentifier: "tuneSetup", sender: nil)
    }
    
    @IBAction func createTuneButton(_ sender: Any){
        self.performSegue(withIdentifier: "createTune", sender: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let index = self.viewModel.selectedTune

        if segue.identifier == "createTune" {
            let viewModel = self.viewModel.getCreateTuneViewModel()
            let view = segue.destination as! CreateTuneView
            view.viewModel = viewModel
        }
        else {
            let viewModel = self.viewModel.getTuneSetupViewModel(forTuneInIndex: index!)
            let view = segue.destination as! TuneSetupView
            view.viewModel = viewModel
        }
    }
 
    @IBAction func beginSearch(_ sender: Any) {
        self.searchTxtField.becomeFirstResponder()
    }
}

extension TuneListView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getTuneCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TuneTableViewCell", for: indexPath) as! TuneTableViewCellView
        
        cell.viewModel = self.viewModel.getTuneCellViewModel(forIndex: indexPath.item)
        cell.viewModel?.delegate = self
        
        return cell
    }
}

extension TuneListView {
    
}
