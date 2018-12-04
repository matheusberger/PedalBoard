//
//  PedalListView.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 10/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class PedalListView: BaseViewController {

    var viewModel: PedalListViewModel!
    
    @IBOutlet weak var pedalTableView: UITableView!
    @IBOutlet weak var filterTxtField: PurpleThinTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel = PedalListViewModel()
        self.viewModel.delegate = self
        
        self.viewModel.getPedals()
        
        self.pedalTableView.delegate = self
        self.pedalTableView.dataSource = self
        
        self.pedalTableView.rowHeight = UITableView.automaticDimension
        self.pedalTableView.estimatedRowHeight = 112
        
        self.filterTxtField.addTarget(self, action: #selector(setFilter(_:)), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.pedalTableView.reloadData()
        
        self.viewModel.clearSelectedPedal()
    }
    
    @objc func setFilter(_ textField: UITextField) {
        self.viewModel.filter = textField.text
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addPedalButton(_ sender: Any) {
        self.performSegue(withIdentifier: "configurePedalSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "configurePedalSegue" {
            let createPedal = segue.destination as! ConfigurePedalView
            createPedal.viewModel = self.viewModel.getCreatePedalViewModel()
        }
    }
}

extension PedalListView: PedalListViewModelDelegate {
    
    func didUpdatePedalList() {
        self.pedalTableView.reloadData()
    }
    
    func editPedal() {
        self.performSegue(withIdentifier: "configurePedalSegue", sender: nil)
    }
}

extension PedalListView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getPedalCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PedalTVC", for: indexPath) as! PedalTVCView
        
        cell.viewModel = self.viewModel.getPedalCellViewModel(forIndex: indexPath.item)
        
        return cell
    }
}
