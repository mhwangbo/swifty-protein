//
//  LoginViewController.swift
//  swifty-protein
//
//  Created by Kristine Sonu on 1/15/19.
//  Copyright © 2019 Kristine Sonu. All rights reserved.
//

import UIKit
import LocalAuthentication

class LoginViewController: UIViewController { 

    @IBOutlet weak var loginText: UITextField!
    @IBOutlet weak var pwdText: UITextField!
    @IBOutlet weak var touchIDB: UIButton!
    @IBOutlet weak var loginB: UIButton!
    var successID : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginB.layer.cornerRadius = 5
        touchIDB.layer.cornerRadius = 5
        loginText.layer.cornerRadius = 5
        pwdText.layer.cornerRadius = 5
        loginB.layer.masksToBounds = true
        touchIDB.layer.masksToBounds = true
        loginText.layer.masksToBounds = true
        pwdText.layer.masksToBounds = true
        successID = false
        let context:LAContext = LAContext()
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            self.touchIDB.isHidden = false
        }
        else {
            self.touchIDB.isHidden = true
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if self.successID == true {
            self.successID = false
            return true
        } else {
            return false
        }
    }

    @IBAction func logInbutton(_ sender: Any) {
        if (loginText.text == "admin" && pwdText.text == "admin") {
            loginText.text = ""
            pwdText.text = ""
            successID = true
        } else {
            print ("error")
            loginText.text = ""
            pwdText.text = ""
            successID = false
        }
    }
    
    @IBAction func touchIDbutton(_ sender: Any) {
        let context:LAContext = LAContext()
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "touch ID 줭!!!!", reply: { (complete, error) in
                if complete {
                    self.successID = false
                    DispatchQueue.main.async() {
                        self.performSegue(withIdentifier: "searchProtein", sender: self)
                    }
                }
                else {
                    self.successID = false
                    print("error touch id")
                }
            })
        }
    }


}

