//
//  TuneListView.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 28/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class TuneListView: UIViewController, TuneListViewModelDelegate {

    fileprivate var viewModel: TuneListViewModel! //initialized by RootTabController
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

    
    @IBAction func createTuneButton(_ sender: Any){
        self.performSegue(withIdentifier: "createTune", sender: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let index = self.tableView.indexPathForSelectedRow
        if index != nil {
            self.tableView.deselectRow(at: index!, animated: true)
        }

        if segue.identifier == "createTune" {
            //get pedal list and initialize viewModel with them
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
 
}

extension TuneListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "tuneSetup", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getTuneCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TuneTableViewCell", for: indexPath) as! TuneTableViewCellView
        
        cell.viewModel = self.viewModel.getTuneCellViewModel(forIndex: indexPath.item)
        
        return cell
    }
}
