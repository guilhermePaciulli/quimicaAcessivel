//
//  Atom.swift
//  QuimicaAcessivel
//
//  Created by Guilherme Paciulli on 21/01/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import SceneKit
import ARKit

class Atom {
    
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
    
    func combination(withAtom atom: Atom) -> Molecule? {
        guard let combination = combining else {
            combining = AtomCombination(atom1: self, atom2: atom)
            return combining?.checkCombination()
        }
        combination.atoms.append(atom.type)
        return combination.checkCombination()
    }
    
    func isMoving() -> Bool {
        return atomObject?.hasActions ?? false
    }
    
}
