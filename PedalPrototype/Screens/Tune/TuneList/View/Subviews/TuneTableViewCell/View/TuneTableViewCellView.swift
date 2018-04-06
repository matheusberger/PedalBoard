//
//  TuneTableViewCellView.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 28/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class TuneTableViewCellView: UITableViewCell {

    @IBOutlet weak var tuneNameLabel: UILabel!
    @IBOutlet weak var roundView: RoundView!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    var viewModel: TuneTableViewCellViewModelProtocol? {
        didSet {
            self.tuneNameLabel.text = viewModel?.getTuneName()
            
            roundView.layer.cornerRadius = 10
            
            roundView.layer.shadowColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
            roundView.layer.shadowRadius = 3.5
            roundView.layer.shadowOpacity = 1
            roundView.layer.shadowOffset = CGSize(width: 0, height: 0)
        }
    }
    
    @IBAction func setupTuneButton(_ sender: Any) {
        self.viewModel?.selectTune()
    }
    
}
