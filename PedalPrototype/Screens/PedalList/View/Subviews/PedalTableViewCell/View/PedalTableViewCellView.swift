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
    
    var viewModel: PedalTableViewCellViewModelProtocol? {
        didSet {
            self.pedalName.text = self.viewModel?.getPedalName()
        }
    }
}
