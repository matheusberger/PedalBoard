//
//  TuneSetupView.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 29/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class TuneSetupView: BaseViewController, TuneSetupViewModelDelegate {
    
    var viewModel: TuneSetupViewModel!


    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var filterTxtField: PurpleThinTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.viewModel.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setFilter(_ sender: Any) {
        self.viewModel.filter = self.filterTxtField.text
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
    
    func didUpdatePedalList() {
        self.collectionView.reloadData()
    }
}

extension TuneSetupView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.getNumberOfPedals()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TuneSetupCVCell", for: indexPath) as! TuneSetupCVCView
        cell.viewModel = self.viewModel.getTuneSetupCVCViewModelForPedal(atIndex: indexPath) as? TuneSetupCVCViewModel
    
        return cell
    }
}
