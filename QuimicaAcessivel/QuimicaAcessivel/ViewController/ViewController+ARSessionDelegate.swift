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
        return 33
    }
    
    // MARK:- Delegate method
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

        guard atomFound.type != .referenceObject else { return }
        if visibleAtoms.isEmpty { timer?.invalidate(); focusedAtomsAlert() }
        visibleAtoms.append(atomFound)
        atomFound.initializeAtom(inScene: worldScene, withAnchor: imageAnchor)
        say("Um átomo de \(atomFound.type.name) entrou em foco")
    }
    
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let imageAnchor = anchor as? ARImageAnchor else {
            print("anchor not found")
            return
        }
        visibleAtoms.forEach({
            guard !$0.flag && !$0.isMoving() else { return }
            $0.didUpdateTo(anchor: imageAnchor)
        })
    }

    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        visibleAtoms.forEach({ [weak self] a0 in
            guard !a0.isMoving(), !a0.flag else { return }
            
            self?.visibleAtoms.forEach({ a1 in
                guard !a1.isMoving(), !(a1 === a0), !a0.flag else { return }
                
                guard let p1 = a0.atomAnchor?.transform.simd_vector3,
                    let p2 = a1.atomAnchor?.transform.simd_vector3 else { return }
                                
                let d = simd_distance(p1, p2)
                if d < minimumDistanceBetweenAtoms {
                    if let molecule = a0.combination(withAtom: a1) {
                        say("Você descobriu \(molecule.name)")
                        a0.flag = true
                        a1.flag = true
                        let fadeOut = SCNAction.fadeOut(duration: 1)
                        a0.atomObject?.runAction(fadeOut)
                        a1.atomObject?.runAction(fadeOut) {
                            DispatchQueue.main.async {
                                if AccessibilityManager.shared.queue.isEmpty {
                                    self?.goToDetails(molecule)
                                } else {
                                    self?.moleculeFound = molecule
                                }
                            }
                        }
                    }
                }
            })
        })
    }
    
}

//guard let camera = self.sceneView?.pointOfView, let object = $0.atomObject else { return }
//guard renderer.isNode(object, insideFrustumOf: camera) else { return }
