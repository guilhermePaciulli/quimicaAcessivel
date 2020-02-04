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
    
    init?(with type: AtomType, andReferenceImage string: String) {
        self.type = type
        guard let image = Resources.getReferenceImage(withName: string) else {
            return nil
        }
        referenceImage = image
    }
    
    func combineIfPossible(withAtom atom: Atom) -> AtomCombination? {
        if let combination = combining {
            return combination.appendIfPossible(atom)
        } else {
            combining = AtomCombination(atom1: self, atom2: atom)
            atom.combining = combining
            return combining
        }
    }
    
    func isMoving() -> Bool {
        return atomObject?.action(forKey: "movement") != nil
    }
    
    func isBlinking() -> Bool {
        return atomObject?.action(forKey: "blink") != nil
    }
    
    func blink() {
        let blink = SCNAction.fadeOut(duration: 0.5)
        let unblink = SCNAction.fadeIn(duration: 0.5)
        let pulseSequence = SCNAction.sequence([blink, unblink])
        let infiniteLoop = SCNAction.repeatForever(pulseSequence)
        atomObject?.runAction(infiniteLoop, forKey: "blink")
    }
    
    func stopBlinking() {
        atomObject?.removeAction(forKey: "blink")
        atomObject?.runAction(SCNAction.fadeIn(duration: 0.5))
    }
    
    static func == (lhs: Atom, rhs: Atom) -> Bool {
        return lhs.atomAnchor == rhs.atomAnchor
    }
    
}
