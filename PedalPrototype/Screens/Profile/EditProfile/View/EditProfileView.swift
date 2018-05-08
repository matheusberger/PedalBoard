//
//  EditProfileView.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 02/05/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class EditProfileView: UIViewController {

    @IBOutlet weak var profileImageView: PurpleImageView!
    @IBOutlet weak var nameTxtField: PurpleTextField!
    @IBOutlet weak var emailTxtField: PurpleTextField!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var viewModel: EditProfileViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel = EditProfileViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.nameTxtField.text = self.viewModel.getUserName()
        self.emailTxtField.text = self.viewModel.getUserEmail()
        self.profileImageView.image = self.viewModel.getUserPicture()
    }
    
    @IBAction func pickProfilePicture(_ sender: Any) {
        //start imagepicker
    }
    
    @IBAction func saveButton(_ sender: Any) {
        self.viewModel.updateUser {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
