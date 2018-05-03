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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var viewModel: EditProfileViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel = EditProfileViewModel()
    }
    
    @IBAction func pickProfilePicture(_ sender: Any) {
        //start imagepicker
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
