//
//  CreatePedalView.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 03/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class CreatePedalView: BaseViewController {
    
    fileprivate var viewModel: CreatePedalViewModel!
    
    
    @IBOutlet weak var pedalName: UITextField!
    @IBOutlet weak var knobTableView: UITableView!
    
    var knobs: [String]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.viewModel = CreatePedalViewModel()
        self.knobTableView.dataSource = self
        
        self.knobs = [String]()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createPedalButton(_ sender: Any) {
        
        guard let name = self.pedalName.text else {
            return
        }
        
        self.viewModel.createPedal(withName: name, andKnobs: self.knobs) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func addKnobButton(_ sender: Any) {
        let alert = UIAlertController(title: "Novo Knob", message: "digite o nome do novo knob", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Confirmar", style: .default, handler: { (action: UIAlertAction) in
            let textField = alert.textFields![0]
            
            if let text = textField.text {
                self.knobs.append(text)
                self.knobTableView.reloadData()
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension CreatePedalView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.knobs.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        }
        
        if indexPath.row == self.knobs.count {
            cell?.textLabel?.text = "adicione mais pedais clicando no botão!"
        }
        else {
            cell?.textLabel?.text = self.knobs[indexPath.row]
        }
        
        return cell!
    }
}
