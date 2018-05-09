//
//  EditProfileView.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 02/05/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit
import Photos

class EditProfileView: BaseViewController {

    @IBOutlet weak var profileImageView: PurpleImageView!
    @IBOutlet weak var nameTxtField: PurpleTextField!
    @IBOutlet weak var emailTxtField: PurpleTextField!
    
    var imgPicker = UIImagePickerController()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var viewModel: EditProfileViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel = EditProfileViewModel()
        self.imgPicker.delegate = self
        
        self.profileImageView.setImage(self.viewModel.getUserImage())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.nameTxtField.text = self.viewModel.getUserName()
        self.emailTxtField.text = self.viewModel.getUserEmail()
    }
    
    @IBAction func pickProfilePicture(_ sender: Any) {
        
        let authorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        if authorizationStatus != .authorized {
            PHPhotoLibrary.requestAuthorization { (newStatus) in
                if newStatus != .authorized {
                    return
                }
            }
        }
        self.imgPicker.allowsEditing = false
        self.imgPicker.sourceType = .photoLibrary
        
        self.present(self.imgPicker, animated: true, completion: nil)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        
        if let image = self.profileImageView.image {
            self.viewModel.setUserImage(image)
        }
        
        self.viewModel.updateUser {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension EditProfileView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            self.profileImageView.setImage(pickedImage)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
