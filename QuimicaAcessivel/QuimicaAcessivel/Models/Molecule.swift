//
//  Molecule.swift
//  QuimicaAcessivel
//
//  Created by Guilherme Paciulli on 23/01/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import ARKit

enum Molecule: CaseIterable {
    case testing
    
    var name: String {
        switch self {
        case .testing:
            return "Testing"
        }
    }
    
    var combination: [AtomType] {
        switch self {
        case .testing:
            return [.hydrogen, .sodium]
        }
    }
    
    var node: SCNNode {
        switch self {
        case .testing:
            let object = SCNBox(width: boxDimension, height: boxDimension, length: boxDimension, chamferRadius: chamferRadius)
            object.firstMaterial?.diffuse.contents = UIColor.white
            let node = SCNNode(geometry: object)
            node.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: object, options: nil))
            return node
        }
    }
    
    var boxDimension: CGFloat {
        return 0.15
    }
    
    var chamferRadius: CGFloat {
        return 1
    }
    
}
