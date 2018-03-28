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
    
    var viewModel: TuneTableViewCellViewModelProtocol? {
        didSet {
            self.tuneNameLabel.text = viewModel?.getTuneName()
        }
    }

}
