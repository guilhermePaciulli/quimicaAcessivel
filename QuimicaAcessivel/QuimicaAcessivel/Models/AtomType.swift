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
//    case sodium
    case oxygen
    
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
//        case .sodium:
//            return .gray
//        case .chloride:
//            return .green
        case .oxygen:
            return .blue
        }
    }
    
    var name: String {
        switch self {
        case .hydrogen:
            return "hidrogênio"
//        case .sodium:
//            return "sódio"
//        case .chloride:
//            return "cloro"
        case .oxygen:
            return "oxigênio"
        }
    }
    
    
    func sound() -> SCNAudioPlayer? {
        return AtomType.hydrogen.rawValue.audioForName
    }
    
    static func displayableAtoms() -> [Atom] {
        guard let extraHydrogen = Atom(with: .hydrogen, andReferenceImage: "hydrogen2") else { return [] }
        return allCases.compactMap { Atom(with: $0) } + [extraHydrogen]
    }
    
    private func radius() -> CGFloat {
        return 0.075
    }
    
}
