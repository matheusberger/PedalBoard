//
//  PedalTVCView.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 10/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class PedalTVCView: UITableViewCell {
    
    @IBOutlet weak var pedalName: UILabel!
    @IBOutlet weak var roundView: RoundShadowView!
    @IBOutlet weak var knobCollectionView: UICollectionView!
    
    var viewModel: PedalTVCViewModelProtocol? {
        didSet {
            self.knobCollectionView.dataSource = self
            
            self.pedalName.text = self.viewModel?.getPedalName()
        }
    }
    
    @IBAction func editButton(_ sender: Any) {
        self.viewModel?.edit()
    }
}


extension PedalTVCView: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let count = self.viewModel?.getKnobCount() else {
            return 0
        }
        
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KnobCollectionViewCell", for: indexPath) as! KnobCollectionViewCell
        
        cell.clipsToBounds = false
        cell.viewmodel = self.viewModel?.getKnobCollectionViewCellViewModel(forIndexPath: indexPath)
        
        return cell
    }
}
