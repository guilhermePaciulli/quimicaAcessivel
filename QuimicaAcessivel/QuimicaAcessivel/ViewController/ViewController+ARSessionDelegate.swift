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
                    proximityDetected(between: a0, and: a1)
                } else {
                    distanceDetected(between: a0, and: a1)
                }
            })
        })
    }
    
    
    func proximityDetected(between atomA: Atom, and atomB: Atom) {
        guard let combination = atomA.combineIfPossible(withAtom: atomB) else { return }
        if let molecule = combination.getMoleculeIfExists() {
            didFoundCombination(ofMolecule: molecule, betweenAtoms: combination.atoms)
        } else if combination.isCombining() && combination.atoms.allSatisfy({ !$0.isBlinking() }) {
            let names = combination.atoms.reduce("", { $0 + ", \($1.type.name)" })
            say("Você está perto de descobrir uma combinação entre os átomos \(names)")
            combination.atoms.forEach({ $0.blink() })
        }
    }
    
    func distanceDetected(between atomA: Atom, and atomB: Atom) {
        if atomA.uncombine(atom: atomB) {
            say("Os átomos \(atomA.type.name) e \(atomB.type.name) foram distanciados")
        }
    }
    
    func didFoundCombination(ofMolecule molecule: Molecule, betweenAtoms atoms: [Atom]) {
        say("Você descobriu \(molecule.name)")
        let fadeOut = SCNAction.fadeOut(duration: 1)
        atoms.forEach({
            $0.flag = true
            if let last = atoms.last, $0 == last {
                $0.atomObject?.runAction(fadeOut) {
                    DispatchQueue.main.async {
                        if AccessibilityManager.shared.hasQueue() {
                            self.moleculeFound = molecule
                        } else {
                            self.goToDetails(molecule)
                        }
                    }
                }
                return
            }
            $0.atomObject?.runAction(fadeOut)
        })
    }
}
