//
//  Atom.swift
//  QuimicaAcessivel
//
//  Created by Guilherme Paciulli on 21/01/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import SceneKit
import ARKit

class Atom: Equatable {
    
    var flag: Bool = false
    var combining: AtomCombination?
    var type: AtomType
    var referenceImage: ARReferenceImage
    var atomAnchor: ARImageAnchor?
    var atomObject: SCNNode?
    var atomScene: SCNScene?
    var runningMovementAction: SCNAction?
    
    init?(with type: AtomType) {
        self.type = type
        guard let image = Resources.referenceImages.first(where: { $0.name == type.rawValue }) else {
            return nil
        }
        referenceImage = image
    }
    
    func combineIfPossible(withAtom atom: Atom) -> AtomCombination? {
        if let otherAtomCombination = atom.combining {
            combining = otherAtomCombination.appendIfPossible(atom)
            return otherAtomCombination
        } else if let combination = combining {
            return combination.appendIfPossible(atom)
        } else {
            combining = AtomCombination(atom1: self, atom2: atom)
            return combining
        }
    }
    
    func uncombine(atom: Atom) -> Bool {
        guard let combination = combining, combination.checkExistence(ofAtom: atom) else { return false }
        combination.atoms.removeAll(where: {
            if $0 == atom {
                return true
            }
            return false
        })
        if combination.atoms.count == 1 {
            combining = nil
            atom.combining = nil
        }
        return true
    }
    
    func isMoving() -> Bool {
        return atomObject?.action(forKey: "movement") != nil
    }
    
    func isBlinking() -> Bool {
        return atomObject?.action(forKey: "blink") != nil
    }
    
    func blink() {
        guard let atom = atomObject?.geometry?.firstMaterial?.diffuse.contents as? UIColor else { return }
        let blink = SCNAction.animateColor(from: atom, to: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), withDuration: 0.5)
        let unblink = SCNAction.animateColor(from: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), to: atom, withDuration: 0.5)
        let pulseSequence = SCNAction.sequence([blink, unblink])
        let infiniteLoop = SCNAction.repeatForever(pulseSequence)
        atomObject?.runAction(infiniteLoop, forKey: "blink")
    }
    
    static func == (lhs: Atom, rhs: Atom) -> Bool {
        return lhs.atomAnchor == rhs.atomAnchor
    }
    
}
