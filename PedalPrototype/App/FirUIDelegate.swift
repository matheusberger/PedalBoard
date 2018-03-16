//
//  FirUIDelegate.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 16/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuthUI
import FirebaseGoogleAuthUI
import FirebaseFacebookAuthUI

class FirUIDelegate: NSObject, FUIAuthDelegate {
    
    var authUI: FUIAuth?
    
    override init() {
        super.init()
        
        self.authUI = FUIAuth.defaultAuthUI()
        self.authUI?.delegate = self
        
        let providers: [FUIAuthProvider] = [FUIGoogleAuth(), FUIFacebookAuth()]
        self.authUI?.providers = providers
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        
        guard error == nil else {
            print(error!)
            return
        }
        
        guard let user = user else {
            return
        }
        
        print("deu bom com \(user.displayName!)")
    }
    
    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        
        let sourceApplication = options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String?
        if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
            return true
        }
        // other URL handling goes here.
        return false
    }
    
    func getAuthViewController() -> UINavigationController {
        return self.authUI!.authViewController()
    }
    
    func singOut(withCompletionBlock completionBlock: @escaping (_ success: Bool) -> Void)  {
        
        var success = true
        
        do {
            try self.authUI!.signOut()
        }
        catch  {
            success = false
        }

        completionBlock(success)
    }
}
