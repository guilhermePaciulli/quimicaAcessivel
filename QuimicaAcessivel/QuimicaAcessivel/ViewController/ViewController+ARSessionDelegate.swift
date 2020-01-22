//
//  ViewController+ARSessionDelegate.swift
//  QuimicaAcessivel
//
//  Created by Guilherme Paciulli on 16/01/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

extension ViewController: ARSessionDelegate {
    
    // MARK:- Delegate methods
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let imageAnchor = anchor as? ARImageAnchor, let worldScene = sceneView?.scene else {
            print("anchor not found")
            return
        }        
        atom.initializeAtom(inScene: worldScene, withAnchor: imageAnchor, andImageNode: node)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        atom.updatePosition(atTime: time)
    }
    
}
