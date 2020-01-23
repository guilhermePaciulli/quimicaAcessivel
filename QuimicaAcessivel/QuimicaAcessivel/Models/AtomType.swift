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
    
    func atomObject() -> SCNNode? {
        switch self {
        case .hydrogen:
            let object = SCNSphere(radius: radius())
            object.firstMaterial?.diffuse.contents = UIColor.red
            return SCNNode(geometry: object)
        case .sodium:
            let object = SCNSphere(radius: radius())
            object.firstMaterial?.diffuse.contents = UIColor.blue
            return SCNNode(geometry: object)
        }
    }
    
    static func displayableAtoms() -> [Atom] {
        return allCases.compactMap { Atom(with: $0) }
    }
    
    private func radius() -> CGFloat {
        return 0.15
    }
    
}
