//
//  PedalTableViewCellView.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 10/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class PedalTableViewCellView: UITableViewCell {
    
    @IBOutlet weak var pedalName: UILabel!
    @IBOutlet weak var roundView: RoundShadowView!
//    @IBOutlet weak var knobBaseView: UIView!
    @IBOutlet weak var knobCollectionView: UICollectionView!
    
    var viewModel: PedalTableViewCellViewModelProtocol? {
        didSet {
            self.pedalName.text = self.viewModel?.getPedalName()
            self.knobCollectionView.dataSource = self
        }
    }
    
    @IBAction func editButton(_ sender: Any) {
        self.viewModel?.edit()
    }
}


extension PedalTableViewCellView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let count = self.viewModel?.getKnobCount() else {
            return 0
        }
        
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KnobCollectionViewCell", for: indexPath) as! KnobCollectionViewCell
        
        cell.viewmodel = self.viewModel?.getKnobCollectionViewCellViewModel(forIndexPath: indexPath)
        
        return cell
    }
}
