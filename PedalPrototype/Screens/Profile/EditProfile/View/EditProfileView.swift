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
        self.imgPicker.allowsEditing = true
        self.imgPicker.sourceType = .photoLibrary
        
        self.present(self.imgPicker, animated: true, completion: nil)
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

extension EditProfileView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        if let pickedImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage {
            
            if let compressedImg = pickedImage.compressTo(1) {
                self.viewModel.setUserImage(compressedImg)
                self.profileImageView.setImage(compressedImg)
            }
            
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
