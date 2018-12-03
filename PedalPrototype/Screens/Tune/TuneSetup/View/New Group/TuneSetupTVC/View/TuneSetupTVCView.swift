//
//  TuneSetupTVCView.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 23/05/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class TuneSetupTVCView: UITableViewCell {
    
    @IBOutlet weak var pedalNameLabel: UILabel!
    @IBOutlet weak var button: PurpleButton!
    @IBOutlet weak var knobCV: UICollectionView!
    @IBOutlet weak var roundBaseView: RoundShadowView!
    @IBOutlet weak var topRoundViewCons: NSLayoutConstraint!
    
    var viewModel: TuneSetupTVCViewModelProtocol! {
        didSet {
            self.pedalNameLabel.text = viewModel.getPedalName()
            self.roundBaseView.frame.origin.y = 0
            
        }
    }
}
