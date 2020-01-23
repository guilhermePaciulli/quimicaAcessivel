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
        guard let imageAnchor = anchor as? ARImageAnchor else {
            print("anchor not found")
            return
        }
        
        guard let worldScene = sceneView?.scene else { print("Scene not initialized"); return }
        guard let atomFound = atoms.first(where: { $0.referenceImage.name == imageAnchor.referenceImage.name }) else {
            print("atom not found in resources")
            return
        }
        
        visibleAtoms.append(atomFound)
        atomFound.initializeAtom(inScene: worldScene, withAnchor: imageAnchor, andImageNode: node)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        visibleAtoms.forEach({ $0.updatePosition(atTime: time) })
    }
    
}
