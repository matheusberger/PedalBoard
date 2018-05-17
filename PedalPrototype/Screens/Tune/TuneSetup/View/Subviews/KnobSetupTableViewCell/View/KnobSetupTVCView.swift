//
//  KnobSetupTVCView.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 01/04/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class KnobSetupTVCView: UITableViewCell {
    
    fileprivate var value: Float! {
        didSet {
            let intV = Int(value)
            self.viewModel.setKnobValue(value: intV)
            self.viewModel.completionHandler(intV)
        }
    }
    
    
    var viewModel: KnobSetupTVCViewModelProtocol! {
        didSet {
            print(viewModel.getKnobName(), viewModel.getKnobValue())
        }
    }
}
