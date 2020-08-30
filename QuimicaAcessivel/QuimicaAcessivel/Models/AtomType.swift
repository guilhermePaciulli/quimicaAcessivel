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
    case oxygen
    case chloride
    case potassium
    case fluoride
    
    func atomObject() -> SCNNode? {
        let object = SCNSphere(radius: radius())
        object.firstMaterial?.diffuse.contents = color
        let node = SCNNode(geometry: object)
        node.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(geometry: object, options: nil))
        return node
    }
    
    var color: UIColor {
        switch self {
        case .hydrogen:
            return .white
        case .sodium:
            return .gray
        case .chloride:
            return .green
        case .oxygen:
            return .red
        case .potassium:
            return .purple
        case .fluoride:
            return .yellow
        }
    }
    
    var name: String {
        switch self {
        case .hydrogen:
            return "hidrogênio"
        case .sodium:
            return "sódio"
        case .chloride:
            return "cloro"
        case .oxygen:
            return "oxigênio"
        case .potassium:
            return "potássio"
        case .fluoride:
            return "flúor"
        }
    }
    
    static func displayableAtoms() -> [Atom] {
        guard let extraHydrogen = Atom(with: .hydrogen, andReferenceImage: "hydrogen2") else { return [] }
        return allCases.compactMap { Atom(with: $0) } + [extraHydrogen]
    }
    
    private func radius() -> CGFloat {
        return 0.075
    }
    
}
