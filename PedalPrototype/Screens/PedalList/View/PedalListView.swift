//
//  PedalListView.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 10/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class PedalListView: UIViewController {

    fileprivate var viewModel: PedalListViewModel! //initialized by RootBarController
    
    @IBOutlet weak var pedalTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.viewModel.delegate = self
        
        self.pedalTableView.dataSource = self
        
        self.viewModel.getPedals()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setViewModel(viewModel: PedalListViewModel) {
        self.viewModel = viewModel
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

extension PedalListView: PedalListViewModelDelegate {
    
    func didUpdatePedalList() {
        self.pedalTableView.reloadData()
    }
}

extension PedalListView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getPedalCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PedalTableViewCell", for: indexPath) as! PedalTableViewCellView
        
        cell.viewModel = self.viewModel.getPedalCellViewModel(forIndex: indexPath.item)
        
        return cell
    }
}
