//
//  PedalListView.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 10/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class PedalListView: BaseViewController {

    var viewModel: PedalListViewModelProtocol!
    
    @IBOutlet weak var pedalTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel.delegate = self
        
        self.pedalTableView.dataSource = self
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension PedalListView: PedalListViewModelDelegate {
    
    func didUpdatePedalList() {
        self.pedalTableView.reloadData()
    }
}

extension PedalListView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getPedalCount()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PedalTableViewCell", for: indexPath) as! PedalTableViewCellView
        
        cell.viewModel = self.viewModel.getPedalCellViewModel(forIndex: indexPath.item)
        
        return cell
    }
}
