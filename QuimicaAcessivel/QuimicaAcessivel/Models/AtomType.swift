//
//  AtomSettingsManager.swift
//  QuimicaAcessivel
//
//  Created by Guilherme Paciulli on 22/01/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit
import SceneKit
import ARKit


enum AtomType: String, CaseIterable {
    case hydrogen
    case sodium
    case chloride
    
    func atomObject() -> SCNNode? {
        switch self {
        case .hydrogen:
            let object = SCNSphere(radius: radius())
            object.firstMaterial?.diffuse.contents = UIColor.red
            let node = SCNNode(geometry: object)
            node.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(geometry: object, options: nil))
            return node
        case .sodium:
            let object = SCNSphere(radius: radius())
            object.firstMaterial?.diffuse.contents = UIColor.blue
            let node = SCNNode(geometry: object)
            node.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(geometry: object, options: nil))
            return node
        case .chloride:
            let object = SCNSphere(radius: radius())
            object.firstMaterial?.diffuse.contents = UIColor.cyan
            let node = SCNNode(geometry: object)
            node.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(geometry: object, options: nil))
            return node
        }
    }
    
    var name: String {
        switch self {
        case .hydrogen:
            return "hidrogênio"
        case .sodium:
            return "sódio"
        case .chloride:
            return "chloride"
        }
    }
    
    
    func sound() -> SCNAudioPlayer? {
        return AtomType.hydrogen.rawValue.audioForName
    }
    
    static func displayableAtoms() -> [Atom] {
        return allCases.compactMap { Atom(with: $0) }
    }
    
    private func radius() -> CGFloat {
        return 0.075
    }
    
}
