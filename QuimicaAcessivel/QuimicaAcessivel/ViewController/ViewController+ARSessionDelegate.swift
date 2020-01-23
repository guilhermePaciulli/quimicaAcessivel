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
    
    var minimumDistanceBetweenAtoms: Float {
        return 31
    }
    
    
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
        visibleAtoms.forEach({ [weak self] a0 in
            a0.updatePosition(atTime: time)
            self?.visibleAtoms.forEach({ a1 in
                guard a1 != a0 else { return }
                guard let o1 = a0.atomObject,
                    let o2 = a1.atomObject else { return }
                
                let d = simd_distance(o1.simdWorldPosition, o2.simdWorldPosition)
                print(d)
                if d < minimumDistanceBetweenAtoms {
                    fatalError()
                }
            })
        })
    }
    
    func session(_ session: ARSession, didRemove anchors: [ARAnchor]) {
    }
    
}
//guard let camera = self.sceneView?.pointOfView, let object = $0.atomObject else { return }
//guard renderer.isNode(object, insideFrustumOf: camera) else { return }
