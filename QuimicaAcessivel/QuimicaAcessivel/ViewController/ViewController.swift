//
//  ViewController.swift
//  QuimicaAcessivel
//
//  Created by Guilherme Paciulli on 16/01/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView?
    var session: ARSession? {
        return sceneView?.session
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView?.delegate = self
        sceneView?.session.delegate = self as! ARSessionDelegate
    }
    
    
    func resetTracking() {
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else {
            fatalError("Missing expected asset catalog resources.")
        }

        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = referenceImages
        session?.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
}
