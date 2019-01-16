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

        @IBOutlet weak var TouchIDbutton: UIButton!
        override func viewDidLoad() {
        super.viewDidLoad()
        
        let context:LAContext = LAContext()
        var autherror:NSError?
        
        context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &autherror)
        
        if autherror != nil {
            TouchIDbutton.isHidden = true
        }
        else {
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "touch ID 줭!!", reply: {(complete, error) -> Void in
                if error != nil {
                    let alert = UIAlertController(title: "Touch ID Fail", message:
                        "Touch ID is not valid.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                else {
                    //self.performSegue(withIdentifier: "SearchProtein", sender: self)
                    print("Touch ID success")
                }
            })
        }
    }
    
/*    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchProtein" {
            let new = segue.destination as! ProteinViewController
            let destination = new
            destination.json = self.json
        }
    }*/
}

