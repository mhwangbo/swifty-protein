//
//  ProteinsceneViewController.swift
//  swifty-protein
//
//  Created by Kristine Sonu on 1/15/19.
//  Copyright © 2019 Kristine Sonu. All rights reserved.
//

import UIKit
import SceneKit

class ProteinsceneViewController: UIViewController {

    @IBOutlet weak var ProteinView: SCNView!
    var pdb_file : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProteinView.allowsCameraControl = true
        ProteinView.autoenablesDefaultLighting = true
        ProteinView.scene = ProteinSCN(pdb_file: pdb_file!)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
