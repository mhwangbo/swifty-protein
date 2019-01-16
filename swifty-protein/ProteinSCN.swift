//
//  ProteinSCN.swift
//  swifty-protein
//
//  Created by Kristine Sonu on 1/15/19.
//  Copyright © 2019 Kristine Sonu. All rights reserved.
//

import Foundation
import SceneKit

class ProteinSCN: SCNScene, SCNNodeRendererDelegate {
    
    var camera: SCNNode!
    init(pdb_file: String) {
        super.init()
        initCamera()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initCamera() {
        camera = SCNNode()
        camera.camera = SCNCamera()
        camera.position = SCNVector3(x:0, y:5, z: 30)
        self.rootNode.addChildNode(camera)
    }
}
