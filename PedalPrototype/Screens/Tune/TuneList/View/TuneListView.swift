//
//  TuneListView.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 28/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class TuneListView: BaseViewController, TuneListViewModelDelegate, TuneTableViewCellViewModelDelegate {

    fileprivate var viewModel: TuneListViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTxtField: PurpleTextField!
    @IBOutlet weak var userProfileButton: CircleButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel = TuneListViewModel()
        
        self.navigationController?.isNavigationBarHidden = true
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.viewModel.delegate = self
        self.viewModel.getTunes()
        self.userProfileButton.setImage(self.viewModel.getUserImage(), for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let rootTabBarController = self.tabBarController as! RootTabController
        rootTabBarController.toogleTabBar(on: true)
    }
    
    func didUpdateTuneList() {
        self.tableView.reloadData()
    }
    
    func didSelectSetup(atIndex index: Int) {
        self.viewModel.selectedTune = index
        self.performSegue(withIdentifier: "createTune", sender: nil)
    }
    
    @IBAction func createTuneButton(_ sender: Any){
        self.performSegue(withIdentifier: "createTune", sender: nil)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if segue.identifier == "createTune" {
            let viewModel = self.viewModel.getConfigureTuneViewModel()
            let view = segue.destination as! ConfigureTuneView
            view.viewModel = viewModel
        }
    }
 
    @IBAction func setFilter(_ sender: Any) {
        self.viewModel.filter = self.searchTxtField.text
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
