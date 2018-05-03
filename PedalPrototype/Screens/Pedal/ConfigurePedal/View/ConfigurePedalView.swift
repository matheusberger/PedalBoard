//
//  CreatePedalView.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 03/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class ConfigurePedalView: BaseViewController {
    
    @IBOutlet weak var pedalName: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var knobsTxtFieldCollection: [PurpleTextField]!
    
    @IBOutlet weak var baseView: RoundView!
    @IBOutlet weak var baseViewTopConstraint: NSLayoutConstraint!
    
    var knobs: [String]!
    var viewModel: ConfigurePedalViewModelProtocol!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.knobs = [String]()
        self.pedalName.text = self.viewModel.getPedalName()
        self.knobsTxtFieldCollection[0].delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let editing = self.viewModel.isEditingPedal()
        
        if editing {
            self.titleLabel.text = "EDIT PEDAL"
            self.viewModel.getKnobs { (knob) in
                self.knobsTxtFieldCollection.last?.text = knob
                self.setupNextKnobTxtField()
            }
        }
        else {
            self.titleLabel.text = "NEW PEDAL"
        }
        
        self.dismissKeyboard()
    }
    
    @IBAction func createPedalButton(_ sender: Any) {
        
        guard let name = self.pedalName.text else {
            return
        }
        
        for txtField in self.knobsTxtFieldCollection {
            if let name = txtField.text {
                if name != ""{
                    self.knobs.append(name)
                }
            }
        }
        
        self.viewModel.configurePedal(withName: name, andKnobs: self.knobs) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addKnobButton(_ sender: Any) {
        
        self.setupNextKnobTxtField()
    }
    
    private func setupNextKnobTxtField() {
        
        guard let last = self.knobsTxtFieldCollection.last else {
            return
        }
        
        let new = PurpleTextField(frame: last.frame)
        new.delegate = self
        new.placeholder = last.placeholder
        
        self.knobsTxtFieldCollection.append(new)
        self.baseView.addSubview(new)
        new.removeConstraints(new.constraints)
        
        new.translatesAutoresizingMaskIntoConstraints = false
        let leadingConstraint = NSLayoutConstraint(item: new, attribute: .leading, relatedBy: .equal, toItem: last, attribute: .leading, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: new, attribute: .trailing, relatedBy: .equal, toItem: last, attribute: .trailing, multiplier: 1, constant: 0)
        let positionConstraint = NSLayoutConstraint(item: new, attribute: .top, relatedBy: .equal, toItem: last, attribute: .bottom, multiplier: 1, constant: 10)
        
        self.baseView.addConstraints([leadingConstraint, trailingConstraint, positionConstraint])
        new.heightAnchor.constraint(equalTo: last.heightAnchor, multiplier: 1).isActive = true
        
        self.baseViewTopConstraint.constant = self.baseViewTopConstraint.constant - 40
        self.view.layoutIfNeeded()
        
        new.becomeFirstResponder()
    }
}

extension ConfigurePedalView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.addKnobButton(Int())
        return true
    }
}
