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
    
    var knobs: [String]!
    var viewModel: ConfigurePedalViewModelProtocol!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.knobs = [String]()
        self.pedalName.text = self.viewModel.getPedalName()
    }
    
    @IBAction func createPedalButton(_ sender: Any) {
        
        guard let name = self.pedalName.text else {
            return
        }
        
        self.viewModel.configurePedal(withName: name, andKnobs: self.knobs) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addKnobButton(_ sender: Any) {
        let alert = UIAlertController(title: "Novo Knob", message: "digite o nome do novo knob", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Confirmar", style: .default, handler: { (action: UIAlertAction) in
            let textField = alert.textFields![0]
            
            if let text = textField.text {
                self.knobs.append(text)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
